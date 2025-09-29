output "table_name" {
    value       = aws_dynamodb_table.terraform_state_lock.name
}

output "table_arn" {
    value       = aws_dynamodb_table.terraform_state_lock.arn
}

output "table_id" {
    value       = aws_dynamodb_table.terraform_state_lock.id
}
