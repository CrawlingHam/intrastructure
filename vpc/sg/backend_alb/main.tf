resource "aws_security_group" "backend_alb" {
    name        = "backend-alb-sg-${var.environment}"
    description = "Security group for backend Application Load Balancer"
    vpc_id      = var.vpc_id

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP"
        protocol    = "tcp"
        from_port   = 80
        to_port     = 80
    }

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTPS"
        protocol    = "tcp"
        from_port   = 443
        to_port     = 443
    }

    egress {
        cidr_blocks = ["0.0.0.0/0"]
        protocol    = "-1"
        from_port   = 0
        to_port     = 0
    }

    tags = merge(local.common_tags, {
        Name = "backend-alb-sg-${var.environment}"
    })
}
