module "backend_alb" {
    security_group_id   = var.backend_security_group_id
    enable_access_logs  = var.enable_access_logs
    access_logs_bucket  = var.access_logs_bucket
    public_subnet_ids   = var.public_subnet_ids
    certificate_arn     = var.certificate_arn
    project_name        = var.project_name
    environment         = var.environment
    managed_by          = var.managed_by
    target_group_name   = "backend-tg"
    vpc_id              = var.vpc_id
    source              = "./shared"
    alb_name            = "backend"
    target_port         = 3000
}