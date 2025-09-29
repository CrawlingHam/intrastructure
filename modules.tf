module "s3" {
    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
    region = var.region
    source = "./s3"
}

module "iam" {
    alb_access_logs_bucket_arn = module.s3.logs.alb_access_logs_bucket_arn
    alb_access_logs_bucket_id = module.s3.logs.alb_access_logs_bucket_id
    source       = "./iam"
}

module "dynamodb" {
    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
    source       = "./dynamodb"
}

module "route53" {
    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
    source       = "./route53"
    alb_module = module.alb
}

module "acm" {
    route53_acm_domain_name  = module.route53.hosted_zones.public_hosted_zone_name
    route53_acm_zone_id      = module.route53.hosted_zones.public_zone_id
    project_name             = var.project_name
    environment              = var.environment
    managed_by               = var.managed_by
    source                   = "./acm"
}

module "vpc" {
    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
    source       = "./vpc"
}

module "alb" {
    frontend_security_group_id  = module.vpc.security_groups.alb.frontend_alb_security_group.security_group_id
    backend_security_group_id   = module.vpc.security_groups.alb.backend_alb_security_group.security_group_id
    access_logs_bucket          = module.s3.logs.alb_access_logs_bucket_id
    public_subnet_ids           = module.vpc.subnets.public_subnet_ids
    certificate_arn             = module.acm.route53_certificate_arn
    vpc_id                      = module.vpc.vpc_id
    project_name                = var.project_name
    environment                 = var.environment
    managed_by                  = var.managed_by
    source                      = "./alb"
    enable_access_logs          = true

    depends_on                  = [module.iam]
}