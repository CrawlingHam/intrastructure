output "terraform_state_lock_table_eu_north_1_name" {
    description = "Name of the DynamoDB table for Terraform state locking in eu-north-1"
    value       = module.terraform_state_lock_eu_north_1.table_name
}

output "terraform_state_lock_table_eu_north_1_arn" {
    description = "ARN of the DynamoDB table for Terraform state locking in eu-north-1"
    value       = module.terraform_state_lock_eu_north_1.table_arn
}