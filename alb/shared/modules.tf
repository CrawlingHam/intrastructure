module "target_groups" {
    target_group_name   = var.target_group_name
    source              = "./target_groups"
    project_name        = var.project_name
    environment         = var.environment
    target_port         = var.target_port
    managed_by          = var.managed_by
    vpc_id              = var.vpc_id
}

module "listeners" {
    target_group_arn    = module.target_groups.target_group_arn
    certificate_arn     = var.certificate_arn
    project_name        = var.project_name
    environment         = var.environment
    managed_by          = var.managed_by
    alb_arn             = aws_lb.alb.arn
    source              = "./listeners"
}