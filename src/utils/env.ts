const ENVIRONMENT_VARIABLES: string[] = [
    "FIREBASE_MESSAGING_SENDER_ID",
    "FIREBASE_STORAGE_BUCKET",
    "FIREBASE_MEASUREMENT_ID",
    "FIREBASE_AUTH_DOMAIN",
    "FIREBASE_PROJECT_ID",
    "FIREBASE_API_KEY",
    "FIREBASE_APP_ID",

    "ALLOWED_ORIGINS",

    "AWS_FLIXBURST_ECS_CLUSTER_NAME",
    "AWS_FLIXBURST_VPC_ID",
];

function validateEnvironmentVariables(): void {
    for (const envVar of ENVIRONMENT_VARIABLES) {
        if (!process.env[envVar]) {
            console.error(`❌ Missing environment variable: ${envVar}`);
            process.exit(1);
        }
    }
}

export { validateEnvironmentVariables };
