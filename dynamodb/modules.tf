module "state_locks" {
    source = "./state_locks/terraform"
    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
}

module "billing" {
    project_name = var.project_name
    common_tags = local.common_tags
    environment = var.environment
    source = "./billing"
}
