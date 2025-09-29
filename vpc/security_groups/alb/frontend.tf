module "frontend_alb" {
    description = "Security group for frontend ALB"
    https_ingress_cidr_blocks = ["0.0.0.0/0"]
    http_ingress_cidr_blocks = ["0.0.0.0/0"]
    egress_cidr_blocks = ["0.0.0.0/0"]
    project_name = var.project_name
    environment = var.environment
    managed_by = var.managed_by
    alb_name = "frontend_alb"
    vpc_id = var.vpc_id
    source = "./shared"
}