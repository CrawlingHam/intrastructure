output "alb_arn" {
    value = aws_lb.alb.arn
}

output "alb_dns_name" {
    value = aws_lb.alb.dns_name
}

output "alb_zone_id" {
    value = aws_lb.alb.zone_id
}

output "https_listener_arn" {
    value = module.listeners.https_listener_arn
}

output "http_listener_arn" {
    value = module.listeners.http_listener_arn
}

output "target_groups" {
    value = module.target_groups
}