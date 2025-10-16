import { Vpc, SecurityGroup, Port, Peer, type IVpc } from "aws-cdk-lib/aws-ec2";
import { Construct } from "constructs";

export class FlixburstSecurityGroupManager {
    public readonly frontend: SecurityGroup;
    public readonly backend: SecurityGroup;

    constructor(scope: Construct, vpc: Vpc | IVpc) {
        this.frontend = new SecurityGroup(scope, "FrontendSecurityGroup", {
            description: "Frontend services security group",
            allowAllOutbound: false,
            vpc,
        });

        this.backend = new SecurityGroup(scope, "BackendSecurityGroup", {
            description: "Backend services security group",
            allowAllOutbound: false,
            vpc,
        });

        this.setupSecurityGroupRules();
    }

    private setupSecurityGroupRules(): void {
        this.backend.addIngressRule(this.frontend, Port.tcp(3000), "Allow frontend to access backend APIs");
        this.frontend.addEgressRule(this.frontend, Port.allTraffic(), "Allow frontend to communicate with itself");
        this.backend.addEgressRule(this.backend, Port.allTraffic(), "Allow backend to communicate with itself");

        this.frontend.addEgressRule(Peer.anyIpv4(), Port.tcp(443), "Allow HTTPS outbound for external APIs");
        this.backend.addEgressRule(Peer.anyIpv4(), Port.tcp(443), "Allow HTTPS outbound for external APIs");
    }

    public getFrontendSecurityGroup(): SecurityGroup {
        return this.frontend;
    }

    public getBackendSecurityGroup(): SecurityGroup {
        return this.backend;
    }

    public getAllSecurityGroups(): { frontend: SecurityGroup; backend: SecurityGroup } {
        return {
            frontend: this.frontend,
            backend: this.backend,
        };
    }

    public logSecurityGroupInfo(type: "frontend" | "backend" | "all"): void {
        console.log("=== Security Group Configuration ===");

        if (type === "frontend" || type === "all") {
            console.log(`Frontend Security Group ID: ${this.frontend.securityGroupId}`);
            console.log(`Frontend Outbound: HTTPS only`);
        }

        if (type === "backend" || type === "all") {
            console.log(`Backend Security Group ID: ${this.backend.securityGroupId}`);
            console.log(`Backend Outbound: HTTPS only`);
        }

        console.log("=====================================");
    }
}
