output "https_listener_arn" {
    value = aws_lb_listener.alb_https_listener.arn
}

output "http_listener_arn" {
    value = aws_lb_listener.alb_http_listener.arn
}