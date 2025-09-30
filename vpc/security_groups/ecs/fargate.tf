resource "aws_security_group" "ecs_fargate" {
    description = "Security group for ECS Fargate tasks"
    name        = "ecs-fargate-sg-${var.environment}"
    vpc_id      = var.vpc_id

    ingress {
        from_port   = var.ecs_fargate_ingress_from_port
        to_port     = var.ecs_fargate_ingress_to_port
        cidr_blocks = var.alb_cidr_blocks
        description = "HTTP from ALB"
        protocol    = "tcp"
    }

    egress {
        cidr_blocks = ["0.0.0.0/0"]
        protocol    = "-1"
        from_port   = 0
        to_port     = 0
    }

    tags = merge(var.common_tags, {
        Name = "ecs-fargate-sg-${var.environment}"
    })
}
