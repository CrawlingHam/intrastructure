resource "aws_lb" "backend" {
    name                    = "backend-alb-${var.environment}"
    security_groups         = [var.security_group_id]
    subnets                 = var.public_subnet_ids
    load_balancer_type      = "application"

    tags                    = local.common_tags
}

resource "aws_lb_target_group" "backend" {
    name        = "backend-tg-${var.environment}"
    port        = 3000
    protocol    = "HTTP"
    vpc_id      = var.vpc_id
    target_type = "ip"

    health_check {
        enabled             = true
        healthy_threshold   = 2
        interval            = 30
        matcher             = "200"
        path                = "/health"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 5
        unhealthy_threshold = 2
    }

    tags = local.common_tags
}

# HTTPS Listener for API
resource "aws_lb_listener" "backend_https" {
    load_balancer_arn = aws_lb.backend.arn
    protocol          = "HTTPS"
    port              = "8443"
    ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
    certificate_arn   = var.certificate_arn

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.backend.arn
    }

    tags = local.common_tags
}

# HTTP to HTTPS Redirect for API
resource "aws_lb_listener" "backend_http" {
    load_balancer_arn = aws_lb.backend.arn
    protocol          = "HTTP"
    port              = "8080"

    default_action {
        type = "redirect"
        redirect {
            port        = "8443"
            protocol    = "HTTPS"
            status_code = "HTTP_301"
        }
    }

    tags = local.common_tags
}