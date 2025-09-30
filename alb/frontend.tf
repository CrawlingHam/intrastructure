module "frontend_alb" {
    security_group_id   = var.frontend_security_group_id
    target_port         = var.frontend_alb_target_port
    enable_access_logs  = var.enable_access_logs
    access_logs_bucket  = var.access_logs_bucket
    public_subnet_ids   = var.public_subnet_ids
    certificate_arn     = var.certificate_arn
    project_name        = var.project_name
    environment         = var.environment
    managed_by          = var.managed_by
    target_group_name   = "frontend-tg"
    vpc_id              = var.vpc_id
    source              = "./shared"
    alb_name            = "frontend"
}