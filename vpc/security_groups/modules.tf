module "alb" {
    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
    vpc_id = var.vpc_id
    source = "./alb"
}

module "ecs" {
    ecs_fargate_ingress_from_port = var.ecs_fargate_ingress_from_port
    ecs_fargate_ingress_to_port = var.ecs_fargate_ingress_to_port
    alb_cidr_blocks = var.alb_cidr_blocks
    environment = var.environment
    common_tags = var.common_tags
    vpc_id = var.vpc_id
    source = "./ecs"
}