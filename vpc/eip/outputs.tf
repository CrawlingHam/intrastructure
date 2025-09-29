output "nat_eip_ids" {
    description = "IDs of the NAT Gateway EIPs"
    value       = aws_eip.nat[*].id
}
