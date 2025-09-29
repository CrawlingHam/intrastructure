output "alb_arn" {
    value = aws_lb.alb.arn
}

output "alb_dns_name" {
    value = aws_lb.alb.dns_name
}

output "alb_zone_id" {
    value = aws_lb.alb.zone_id
}

output "alb_target_group_arn" {
    value = module.target_groups.target_group_arn
}

output "https_listener_arn" {
    value = module.listeners.https_listener_arn
}

output "http_listener_arn" {
    value = module.listeners.http_listener_arn
}