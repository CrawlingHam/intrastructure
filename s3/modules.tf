module "state" {
    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
    source = "./state/terraform"
}


module "logs" {
    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
    region       = var.region
    source = "./logs"
}