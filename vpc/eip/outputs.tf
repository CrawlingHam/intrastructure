output "nat_eip_ids" {
    value       = aws_eip.nat[*].id
}
