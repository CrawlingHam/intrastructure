output "target_group_arn" {
    value = aws_lb_target_group.alb_target_group.arn
}

output "target_port" {
    value = aws_lb_target_group.alb_target_group.port
}
