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

module "acm" {
    source = "./acm"

    route53_acm_domain_name = module.route53.flixburst_public_hosted_zone.public_hosted_zone_name
    route53_acm_zone_id = module.route53.flixburst_public_hosted_zone.public_zone_id
    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
}