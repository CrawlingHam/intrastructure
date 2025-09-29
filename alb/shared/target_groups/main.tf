resource "aws_lb_target_group" "alb_target_group" {
    name        = "${var.target_group_name}-${var.environment}"
    port        = var.target_port
    vpc_id      = var.vpc_id
    protocol    = "HTTP"
    target_type = "ip"

    health_check {
        port                = "traffic-port"
        path                = "/health"
        protocol            = "HTTP"
        matcher             = "200"
        enabled             = true
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
    }

    tags = local.common_tags
}