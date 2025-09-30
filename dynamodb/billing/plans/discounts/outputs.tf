output "discounts_table_name" {
    value = aws_dynamodb_table.discounts.name
}

output "discounts_table_arn" {
    value = aws_dynamodb_table.discounts.arn
}

output "discounts_table_id" {
    value = aws_dynamodb_table.discounts.id
}
