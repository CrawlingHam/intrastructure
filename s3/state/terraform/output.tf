output "terraform_state_bucket_eu_north_1_name" {
    description = "Name of the S3 bucket for Terraform state in eu-north-1"
    value       = module.terraform_state_bucket_eu_north_1.terraform_state_bucket_name
}

output "terraform_state_bucket_eu_north_1_arn" {
    description = "ARN of the S3 bucket for Terraform state in eu-north-1"
    value       = module.terraform_state_bucket_eu_north_1.terraform_state_bucket_arn
}