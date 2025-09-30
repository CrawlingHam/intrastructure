module "alb" {
    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
    vpc_id = var.vpc_id
    source = "./alb"
}

module "ecs" {
    alb_cidr_blocks = var.alb_cidr_blocks
    environment = var.environment
    common_tags = var.common_tags
    vpc_id = var.vpc_id
    source = "./ecs"
}