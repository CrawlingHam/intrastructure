module "flixburst_public_hosted_zone" {
    source = "./hosted_zones"
    
    public_hosted_zone_name   = "flixburst.com"
    public_hosted_zone_domain = "flixburst.com"
    project_name       = var.project_name
    environment        = var.environment
    managed_by         = var.managed_by
}