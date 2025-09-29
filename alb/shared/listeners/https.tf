resource "aws_lb_listener" "alb_https_listener" {
    ssl_policy        = "ELBSecurityPolicy-TLS13-1-3-2021-06"
    certificate_arn   = var.certificate_arn
    load_balancer_arn = var.alb_arn
    protocol          = "HTTPS"
    port              = "443"

    default_action {
        target_group_arn = var.target_group_arn
        type             = "forward"
    }

    tags = local.common_tags
}