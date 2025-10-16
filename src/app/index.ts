import { EmailTemplatesStack, FlixburstECSLandingTaskDefinitionStack } from "../templates";
import { validateEnvironmentVariables } from "../utils";
import { Environment, App } from "aws-cdk-lib";
import "source-map-support/register";
import { config } from "dotenv";
config();

const app = new App();

const env: Environment = {
    account: process.env.CDK_DEFAULT_ACCOUNT,
    region: process.env.CDK_DEFAULT_REGION,
};

validateEnvironmentVariables();

new EmailTemplatesStack(app, "EmailTemplatesStack", { env });
new FlixburstECSLandingTaskDefinitionStack(app, "FlixburstECSLandingTaskDefinitionStack", { env });
