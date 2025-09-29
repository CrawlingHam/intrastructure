output "backend_alb_dns_name" {
    value = module.backend_alb.alb_dns_name
}

output "backend_alb_zone_id" {
    value = module.backend_alb.alb_zone_id
}

output "frontend_alb_dns_name" {
    value = module.frontend_alb.alb_dns_name
}

output "frontend_alb_zone_id" {
    value = module.frontend_alb.alb_zone_id
}