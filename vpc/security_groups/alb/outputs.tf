output "backend_alb_security_group" {
    value = module.backend_alb
}

output "frontend_alb_security_group" {
    value = module.frontend_alb
}