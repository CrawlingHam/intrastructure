output "security_group_id" {
    description = "ID of the backend ALB security group"
    value       = aws_security_group.backend_alb.id
}
