module "s3" {
    source = "./s3"

    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
}

module "dynamodb" {
    source = "./dynamodb"

    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
}

module "route53" {
    source = "./route53"

    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
}

