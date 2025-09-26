output "security_group_id" {
    description = "ID of the frontend ALB security group"
    value       = aws_security_group.frontend_alb.id
}
