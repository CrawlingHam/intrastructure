import { Distribution, ViewerProtocolPolicy } from "aws-cdk-lib/aws-cloudfront";
import { Stack, StackProps, CfnOutput, RemovalPolicy } from "aws-cdk-lib";
import { BucketDeployment, Source } from "aws-cdk-lib/aws-s3-deployment";
import { BlockPublicAccess, Bucket } from "aws-cdk-lib/aws-s3";
import { S3Origin } from "aws-cdk-lib/aws-cloudfront-origins";
import { Construct } from "constructs";
import { join } from "path";

export class EmailTemplatesStack extends Stack {
    constructor(scope: Construct, id: string, props?: StackProps) {
        super(scope, id, props);

        const bucket: Bucket = new Bucket(this, "EmailTemplateAssetsBucket", {
            bucketName: `my-app-email-assets-${this.account}-${this.region}`,
            blockPublicAccess: BlockPublicAccess.BLOCK_ALL,
            removalPolicy: RemovalPolicy.DESTROY, // Automatically delete bucket on stack deletion (for dev/test)
            autoDeleteObjects: true, // Automatically delete objects when bucket is destroyed
            publicReadAccess: false,
        });

        const distribution = new Distribution(this, "EmailAssetsDistribution", {
            defaultBehavior: {
                // @ts-ignore - S3Origin is deprecated but still functional
                origin: new S3Origin(bucket),
                viewerProtocolPolicy: ViewerProtocolPolicy.REDIRECT_TO_HTTPS,
            },
            defaultRootObject: "index.html",
        });

        new CfnOutput(this, "EmailAssetsBucketName", {
            description: "Name of the S3 bucket for email assets",
            value: bucket.bucketName,
        });

        new BucketDeployment(this, "EmailAssetsDeployment", {
            sources: [Source.asset(join(__dirname, "../../../../templates/emails/out"))],
            destinationBucket: bucket,
            destinationKeyPrefix: "templates",
        });

        new CfnOutput(this, "EmailAssetsCloudFrontUrl", {
            description: "CloudFront URL for email assets",
            value: `https://${distribution.distributionDomainName}`,
        });
    }
}
