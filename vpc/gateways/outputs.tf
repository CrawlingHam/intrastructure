output "internet_gateway_id" {
    value       = aws_internet_gateway.main.id
}

output "nat_gateway_ids" {
    value       = aws_nat_gateway.main[*].id
}