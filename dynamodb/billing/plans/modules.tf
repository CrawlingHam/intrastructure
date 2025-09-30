module "discounts" {
    project_name = var.project_name
    environment = var.environment
    common_tags = var.common_tags
    source = "./discounts"
}