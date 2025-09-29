module "state_locks" {
    source = "./state_locks/terraform"

    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
}