resource "aws_lb" "frontend" {
    name                    = "frontend-alb-${var.environment}"
    security_groups         = [var.security_group_id]
    subnets                 = var.public_subnet_ids
    load_balancer_type      = "application"

    tags                    = local.common_tags
}

resource "aws_lb_target_group" "frontend" {
    name        = "frontend-tg-${var.environment}"
    port        = 3000
    protocol    = "HTTP"
    vpc_id      = var.vpc_id
    target_type = "ip"

    health_check {
        enabled             = true
        healthy_threshold   = 2
        interval            = 30
        matcher             = "200"
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 5
        unhealthy_threshold = 2
    }

    tags = local.common_tags
}

# HTTPS Listener
resource "aws_lb_listener" "frontend_https" {
    load_balancer_arn = aws_lb.frontend.arn
    protocol          = "HTTPS"
    port              = "443"
    ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
    certificate_arn   = var.certificate_arn

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.frontend.arn
    }

    tags = local.common_tags
    
    depends_on = [var.certificate_validation_arn]
}

# HTTP to HTTPS Redirect
resource "aws_lb_listener" "frontend_http" {
    load_balancer_arn = aws_lb.frontend.arn
    protocol          = "HTTP"
    port              = "80"

    default_action {
        type = "redirect"
        redirect {
            port        = "443"
            protocol    = "HTTPS"
            status_code = "HTTP_301"
        }
    }

    tags = local.common_tags
}