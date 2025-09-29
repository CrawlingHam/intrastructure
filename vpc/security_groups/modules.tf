module "alb" {
    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
    vpc_id = var.vpc_id
    source = "./alb"
}