resource "aws_security_group" "alb" {
    name        = "${var.alb_name}-sg-${var.environment}"
    description = var.description
    vpc_id      = var.vpc_id

    ingress {
        cidr_blocks = var.http_ingress_cidr_blocks
        description = "HTTP"
        protocol    = "tcp"
        from_port   = 80
        to_port     = 80
    }

    ingress {
        cidr_blocks = var.https_ingress_cidr_blocks
        description = "HTTPS"
        protocol    = "tcp"
        from_port   = 443
        to_port     = 443
    }

    egress {
        cidr_blocks = var.egress_cidr_blocks
        protocol    = "-1"
        from_port   = 0
        to_port     = 0
    }

    tags = merge(local.common_tags, {
        Name = "${var.alb_name}-sg-${var.environment}"
    })
}
