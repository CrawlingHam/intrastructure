import { Vpc, Subnet, SubnetType, type IVpc, type ISubnet } from "aws-cdk-lib/aws-ec2";
import { CfnOutput } from "aws-cdk-lib";
import { Construct } from "constructs";

export class FlixburstSubnetsStack {
    public readonly publicSubnets: ISubnet[];
    public readonly privateSubnets: ISubnet[];
    public readonly privateWithEgressSubnets: ISubnet[];

    constructor(
        scope: Construct,
        vpc: Vpc | IVpc,
        subnetIds?: {
            public?: string[];
            private?: string[];
            privateWithEgress?: string[];
        }
    ) {
        // Use existing subnets if provided, otherwise use VPC subnets
        this.publicSubnets = this.getSubnets(scope, vpc, subnetIds?.public, SubnetType.PUBLIC);
        this.privateSubnets = this.getSubnets(scope, vpc, subnetIds?.private, SubnetType.PRIVATE_ISOLATED);
        this.privateWithEgressSubnets = this.getSubnets(scope, vpc, subnetIds?.privateWithEgress, SubnetType.PRIVATE_WITH_EGRESS);

        // Output subnet information
        this.createOutputs(scope);
    }

    private getSubnets(scope: Construct, vpc: Vpc | IVpc, subnetIds?: string[], subnetType?: SubnetType): ISubnet[] {
        if (subnetIds && subnetIds.length > 0) {
            // Use existing subnets by ID
            return subnetIds.map((id, index) => Subnet.fromSubnetId(scope, `ExistingSubnet-${subnetType}-${index}`, id));
        } else if (subnetType) {
            // Use VPC subnets by type
            return vpc.selectSubnets({ subnetType }).subnets;
        } else {
            // Fallback to all subnets
            return vpc.publicSubnets.concat(vpc.privateSubnets);
        }
    }

    private createOutputs(scope: Construct): void {
        // Public subnets
        new CfnOutput(scope, "PublicSubnetIds", {
            value: this.publicSubnets.map((subnet) => subnet.subnetId).join(","),
            description: "Public Subnet IDs",
        });

        // Private subnets
        new CfnOutput(scope, "PrivateSubnetIds", {
            value: this.privateSubnets.map((subnet) => subnet.subnetId).join(","),
            description: "Private Subnet IDs",
        });

        // Private with egress subnets
        new CfnOutput(scope, "PrivateWithEgressSubnetIds", {
            value: this.privateWithEgressSubnets.map((subnet) => subnet.subnetId).join(","),
            description: "Private with Egress Subnet IDs",
        });
    }

    /**
     * Get public subnets
     */
    public getPublicSubnets(): ISubnet[] {
        return this.publicSubnets;
    }

    /**
     * Get private subnets
     */
    public getPrivateSubnets(): ISubnet[] {
        return this.privateSubnets;
    }

    /**
     * Get private with egress subnets
     */
    public getPrivateWithEgressSubnets(): ISubnet[] {
        return this.privateWithEgressSubnets;
    }

    /**
     * Get all subnets
     */
    public getAllSubnets(): { public: ISubnet[]; private: ISubnet[]; privateWithEgress: ISubnet[] } {
        return {
            public: this.publicSubnets,
            private: this.privateSubnets,
            privateWithEgress: this.privateWithEgressSubnets,
        };
    }

    /**
     * Get subnet IDs as strings
     */
    public getSubnetIds(): { public: string[]; private: string[]; privateWithEgress: string[] } {
        return {
            public: this.publicSubnets.map((subnet) => subnet.subnetId),
            private: this.privateSubnets.map((subnet) => subnet.subnetId),
            privateWithEgress: this.privateWithEgressSubnets.map((subnet) => subnet.subnetId),
        };
    }

    /**
     * Log subnet information
     */
    public logSubnetInfo(): void {
        console.log("=== Subnet Configuration ===");
        console.log(`Public Subnets: ${this.publicSubnets.length}`);
        this.publicSubnets.forEach((subnet, index) => {
            console.log(`  ${index + 1}. ${subnet.subnetId}`);
        });
        console.log(`Private Subnets: ${this.privateSubnets.length}`);
        this.privateSubnets.forEach((subnet, index) => {
            console.log(`  ${index + 1}. ${subnet.subnetId}`);
        });
        console.log(`Private with Egress Subnets: ${this.privateWithEgressSubnets.length}`);
        this.privateWithEgressSubnets.forEach((subnet, index) => {
            console.log(`  ${index + 1}. ${subnet.subnetId}`);
        });
        console.log("=============================");
    }
}
