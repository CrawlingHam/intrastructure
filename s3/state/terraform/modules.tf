module "terraform_state_bucket_eu_north_1" {
    source = "../modules"

    common_tags  = local.common_tags
    project_name = var.project_name
    environment  = var.environment
    region       = "eu-north-1"
}
