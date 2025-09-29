module "clusters" {
    project_name = var.project_name
    environment = var.environment
    managed_by = var.managed_by
    source = "./clusters"
}
