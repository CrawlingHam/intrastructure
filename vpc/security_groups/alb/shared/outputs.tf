output "security_group_id" {
    value = aws_security_group.alb.id
}

output "security_group_name" {
    value = aws_security_group.alb.name
}

output "security_group_arn" {
    value = aws_security_group.alb.arn
}