import { Cluster, type ICluster } from "aws-cdk-lib/aws-ecs";
import { Vpc, type IVpc } from "aws-cdk-lib/aws-ec2";
import { CfnOutput } from "aws-cdk-lib";
import { Construct } from "constructs";

export class FlixburstClusterManager {
    public readonly cluster: ICluster;

    constructor(scope: Construct, vpc: Vpc | IVpc, clusterName?: string) {
        const clusterNameToUse = clusterName || process.env.AWS_FLIXBURST_ECS_CLUSTER_NAME!;

        this.cluster = Cluster.fromClusterAttributes(scope, "ExistingCluster", {
            clusterName: clusterNameToUse,
            vpc,
        });

        new CfnOutput(scope, "ClusterName", {
            value: this.cluster.clusterName,
            description: "ECS Cluster Name",
        });

        new CfnOutput(scope, "ClusterArn", {
            value: this.cluster.clusterArn,
            description: "ECS Cluster ARN",
        });
    }

    /**
     * Get the cluster instance
     */
    public getCluster(): ICluster {
        return this.cluster;
    }

    /**
     * Get cluster name
     */
    public getClusterName(): string {
        return this.cluster.clusterName;
    }

    /**
     * Get cluster ARN
     */
    public getClusterArn(): string {
        return this.cluster.clusterArn;
    }

    /**
     * Log cluster information
     */
    public logClusterInfo(): void {
        console.log("=== ECS Cluster Configuration ===");
        console.log(`Cluster Name: ${this.getClusterName()}`);
        console.log(`Cluster ARN: ${this.getClusterArn()}`);
        console.log(`Container Insights: Enabled`);
        console.log("==================================");
    }
}
