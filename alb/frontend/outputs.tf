output "alb_arn" {
    description = "ARN of the frontend Application Load Balancer"
    value       = aws_lb.frontend.arn
}

output "alb_dns_name" {
    description = "DNS name of the frontend Application Load Balancer"
    value       = aws_lb.frontend.dns_name
}

output "target_group_arn" {
    description = "ARN of the frontend target group"
    value       = aws_lb_target_group.frontend.arn
}

output "listener_arn" {
    description = "ARN of the frontend HTTPS load balancer listener"
    value       = aws_lb_listener.frontend_https.arn
}

output "zone_id" {
    description = "The zone ID of the frontend Application Load Balancer"
    value       = aws_lb.frontend.zone_id
}