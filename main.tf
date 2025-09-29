terraform {
    required_version = ">=1.10.6"

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }

    backend "s3" {
        # Backend configuration is passed via -backend-config in workflow
    }
}