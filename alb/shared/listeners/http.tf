resource "aws_lb_listener" "alb_http_listener" {
    load_balancer_arn = var.alb_arn
    protocol          = "HTTP"
    port              = "80"

    default_action {
        type = "redirect"
        redirect {
            status_code = "HTTP_301"
            protocol    = "HTTPS"
            port        = "443"
        }
    }

    tags = local.common_tags
}