module "hosted_zones" {
    project_name                = var.project_name
    source                      = "./hosted_zones"
    public_hosted_zone_name     = "flixburst.com"
    public_hosted_zone_domain   = "flixburst.com"
    environment                 = var.environment
    managed_by                  = var.managed_by
}

module "dns_records" {
    hosted_zone_name        = module.hosted_zones.public_hosted_zone_name
    frontend_alb_dns_name   = var.alb_module.frontend_alb_dns_name
    frontend_alb_zone_id    = var.alb_module.frontend_alb_zone_id
    backend_alb_dns_name    = var.alb_module.backend_alb_dns_name
    backend_alb_zone_id     = var.alb_module.backend_alb_zone_id
    hosted_zone_id          = module.hosted_zones.public_zone_id
    source                  = "./records"
    depends_on = [ var.alb_module ]
}