output "terraform_state_bucket_name" {
    description = "Name of the S3 bucket for Terraform state"
    value       = aws_s3_bucket.terraform_state_bucket.id
}

output "terraform_state_bucket_arn" {
    description = "ARN of the S3 bucket for Terraform state"
    value       = aws_s3_bucket.terraform_state_bucket.arn
}

output "terraform_state_bucket_domain_name" {
    description = "Domain name of the S3 bucket for Terraform state"
    value       = aws_s3_bucket.terraform_state_bucket.bucket_domain_name
}
