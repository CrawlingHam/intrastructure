import { Vpc, SubnetType, type IVpc } from "aws-cdk-lib/aws-ec2";
import { CfnOutput } from "aws-cdk-lib";
import { Construct } from "constructs";
import {
    type IApplicationLoadBalancer,
    type IApplicationListener,
    ApplicationLoadBalancer,
    ApplicationProtocol,
    ListenerAction,
} from "aws-cdk-lib/aws-elasticloadbalancingv2";
import { FlixburstSubnetsStack } from "../subnets";

export class FlixburstLoadBalancerStack {
    public readonly loadBalancer: IApplicationLoadBalancer;
    public readonly listener: IApplicationListener;
    public readonly subnetManager: FlixburstSubnetsStack;

    constructor(
        scope: Construct,
        vpc: Vpc | IVpc,
        subnetIds?: {
            public?: string[];
            private?: string[];
            privateWithEgress?: string[];
        }
    ) {
        // Initialize subnet manager
        console.log("subnetIds", subnetIds);
        this.subnetManager = new FlixburstSubnetsStack(scope, vpc, subnetIds);

        // Use existing subnets if provided, otherwise use public subnets
        const subnetConfig =
            subnetIds?.public && subnetIds.public.length > 0 ? { subnets: this.subnetManager.getPublicSubnets() } : { subnetType: SubnetType.PUBLIC };

        this.loadBalancer = new ApplicationLoadBalancer(scope, "FlixburstLoadBalancer", {
            internetFacing: true,
            vpcSubnets: subnetConfig,
            vpc,
        });

        // Add listener to the load balancer
        this.listener = this.loadBalancer.addListener("FlixburstListener", {
            protocol: ApplicationProtocol.HTTP,
            defaultAction: ListenerAction.fixedResponse(404, {
                contentType: "text/plain",
                messageBody: "Not Found",
            }),
            port: 80,
        });

        // Output load balancer URL
        new CfnOutput(scope, "LoadBalancerUrl", {
            value: `http://${this.loadBalancer.loadBalancerDnsName}`,
            description: "Load Balancer URL",
        });
    }

    /**
     * Get the load balancer instance
     */
    public getLoadBalancer(): IApplicationLoadBalancer {
        return this.loadBalancer;
    }

    /**
     * Get the listener instance
     */
    public getListener(): IApplicationListener {
        return this.listener;
    }

    /**
     * Get the subnet manager instance
     */
    public getSubnetManager(): FlixburstSubnetsStack {
        return this.subnetManager;
    }

    /**
     * Get load balancer DNS name
     */
    public getDnsName(): string {
        return this.loadBalancer.loadBalancerDnsName;
    }

    /**
     * Get load balancer ARN
     */
    public getArn(): string {
        return this.loadBalancer.loadBalancerArn;
    }

    /**
     * Log load balancer information
     */
    public logLoadBalancerInfo(): void {
        console.log("=== Load Balancer Configuration ===");
        console.log(`Load Balancer DNS: ${this.getDnsName()}`);
        console.log(`Load Balancer ARN: ${this.getArn()}`);
        console.log(`Listener Port: 80`);
        console.log(`Protocol: HTTP`);
        console.log("====================================");
    }
}
