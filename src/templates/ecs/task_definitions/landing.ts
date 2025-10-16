import { Role, PolicyStatement, PolicyDocument, ServicePrincipal, ManagedPolicy, Effect } from "aws-cdk-lib/aws-iam";
import { FargateService, ContainerImage, Protocol, LogDrivers, FargateTaskDefinition } from "aws-cdk-lib/aws-ecs";
import { FlixburstSecurityGroupManager, FlixburstLoadBalancerStack } from "../../vpc";
import { ApplicationProtocol } from "aws-cdk-lib/aws-elasticloadbalancingv2";
import { Vpc, SubnetType, Port, type IVpc } from "aws-cdk-lib/aws-ec2";
import { Stack, StackProps, CfnOutput } from "aws-cdk-lib";
import { FlixburstClusterManager } from "../cluster";
import { LogGroup } from "aws-cdk-lib/aws-logs";
import { Duration } from "aws-cdk-lib";
import { Construct } from "constructs";

export class FlixburstECSLandingTaskDefinitionStack extends Stack {
    constructor(scope: Construct, id: string, props?: StackProps) {
        super(scope, id, props);

        const vpc: IVpc = Vpc.fromLookup(this, "FlixburstVpc", {
            vpcId: process.env.AWS_FLIXBURST_VPC_ID!,
            region: this.region,
            isDefault: false,
        });

        const clusterManager = new FlixburstClusterManager(this, vpc);
        const cluster = clusterManager.getCluster();

        const securityGroupManager = new FlixburstSecurityGroupManager(this, vpc);
        const frontendSecurityGroup = securityGroupManager.getFrontendSecurityGroup();

        const loadBalancerManager = new FlixburstLoadBalancerStack(this, vpc, {
            private: vpc.privateSubnets.map((subnet) => subnet.subnetId),
            public: vpc.publicSubnets.map((subnet) => subnet.subnetId),
        });
        const loadBalancer = loadBalancerManager.getLoadBalancer();
        const listener = loadBalancerManager.getListener();

        const taskDefinition = new FargateTaskDefinition(this, "FlixburstTaskDefinition", {
            executionRole: this.createExecutionRole(),
            family: "flixburst-task-definition",
            taskRole: this.createTaskRole(),
            memoryLimitMiB: 512,
            cpu: 256,
        });

        const existingLogGroup = LogGroup.fromLogGroupName(this, "ExistingLogGroup", "/ecs/flixburst");

        const _container = taskDefinition.addContainer("flixburst-container", {
            image: ContainerImage.fromRegistry("flixburst/images:latest"),
            portMappings: [
                {
                    containerPort: 80,
                    protocol: Protocol.TCP,
                },
            ],
            environment: {
                NODE_ENV: "production",
            },
            logging: LogDrivers.awsLogs({
                streamPrefix: "flixburst",
                logGroup: existingLogGroup,
            }),
            healthCheck: {
                command: ["CMD-SHELL", "curl -f http://localhost:80/health || exit 1"],
                startPeriod: Duration.seconds(60),
                interval: Duration.seconds(30),
                timeout: Duration.seconds(5),
                retries: 3,
            },
        });

        // Create ECS Service
        const service = new FargateService(this, "FlixburstService", {
            securityGroups: [frontendSecurityGroup],
            serviceName: "flixburst-service",
            taskDefinition: taskDefinition,
            enableExecuteCommand: true,
            assignPublicIp: false,
            cluster: cluster,
            desiredCount: 1,
            vpcSubnets: {
                subnetType: SubnetType.PRIVATE_WITH_EGRESS,
            },
        });

        // Add target group for the service
        const targetGroup = listener.addTargets("FlixburstTargets", {
            protocol: ApplicationProtocol.HTTP,
            targets: [service],
            healthCheck: {
                interval: Duration.seconds(30),
                timeout: Duration.seconds(5),
                unhealthyThresholdCount: 3,
                healthyThresholdCount: 2,
                healthyHttpCodes: "200",
                path: "/health",
                enabled: true,
            },
            port: 80,
        });

        // Allow load balancer to access the service
        frontendSecurityGroup.addIngressRule(loadBalancer.connections.securityGroups[0], Port.tcp(80), "Allow ALB to access Landing service");

        // Log infrastructure configuration
        clusterManager.logClusterInfo();
        securityGroupManager.logSecurityGroupInfo("frontend");
        loadBalancerManager.logLoadBalancerInfo();

        // Output important values

        new CfnOutput(this, "ServiceName", {
            value: service.serviceName,
            description: "ECS Service Name",
        });

        new CfnOutput(this, "TaskDefinitionFamily", {
            value: taskDefinition.family,
            description: "Task Definition Family",
        });
    }

    private createExecutionRole(): Role {
        return new Role(this, "LandingExecutionRole", {
            assumedBy: new ServicePrincipal("ecs-tasks.amazonaws.com"),
            managedPolicies: [ManagedPolicy.fromAwsManagedPolicyName("service-role/AmazonECSTaskExecutionRolePolicy")],
            inlinePolicies: {
                EcrAccess: new PolicyDocument({
                    statements: [
                        new PolicyStatement({
                            effect: Effect.ALLOW,
                            actions: ["ecr:GetAuthorizationToken"],
                            resources: ["*"],
                        }),
                        new PolicyStatement({
                            effect: Effect.ALLOW,
                            actions: ["ecr:BatchCheckLayerAvailability", "ecr:GetDownloadUrlForLayer", "ecr:BatchGetImage"],
                            resources: [
                                `arn:aws:ecr:${this.region}:${this.account}:repository/flixburst/images`,
                                `arn:aws:ecr:${this.region}:${this.account}:repository/flixburst/images/*`,
                            ],
                        }),
                    ],
                }),
            },
        });
    }

    private createTaskRole(): Role {
        return new Role(this, "LandingTaskRole", {
            assumedBy: new ServicePrincipal("ecs-tasks.amazonaws.com"),
            // Landing page has minimal permissions - only what it needs
            inlinePolicies: {
                CloudWatchLogs: new PolicyDocument({
                    statements: [
                        new PolicyStatement({
                            effect: Effect.ALLOW,
                            actions: ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"],
                            resources: [`arn:aws:logs:${this.region}:${this.account}:log-group:/ecs/flixburst*`],
                        }),
                    ],
                }),
            },
        });
    }
}
