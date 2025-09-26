output "alb_arn" {
    description = "ARN of the backend Application Load Balancer"
    value       = aws_lb.backend.arn
}

output "alb_dns_name" {
    description = "DNS name of the backend Application Load Balancer"
    value       = aws_lb.backend.dns_name
}

output "target_group_arn" {
    description = "ARN of the backend target group"
    value       = aws_lb_target_group.backend.arn
}

output "listener_arn" {
    description = "ARN of the backend load balancer listener"
    value       = aws_lb_listener.backend.arn
}
