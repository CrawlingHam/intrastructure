output "internet_gateway_id" {
    description = "ID of the Internet Gateway"
    value       = aws_internet_gateway.main.id
}

output "nat_gateway_ids" {
    description = "IDs of the NAT Gateways"
    value       = aws_nat_gateway.main[*].id
}