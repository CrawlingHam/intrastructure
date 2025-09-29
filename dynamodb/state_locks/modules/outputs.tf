output "table_name" {
    description = "Name of the DynamoDB table for Terraform state locking"
    value       = aws_dynamodb_table.terraform_state_lock.name
}

output "table_arn" {
    description = "ARN of the DynamoDB table for Terraform state locking"
    value       = aws_dynamodb_table.terraform_state_lock.arn
}

output "table_id" {
    description = "ID of the DynamoDB table for Terraform state locking"
    value       = aws_dynamodb_table.terraform_state_lock.id
}
