output "vpc_id" {
    value       = aws_vpc.main.id
}

output "security_groups" {
    value = module.security_groups
}

output "subnets" {
    value = module.subnets
}