module "frontend_alb_sg" {
    source = "./vpc/sg/frontend_alb"
    
    project_name = var.project_name
    environment = var.environment
    managed_by = var.managed_by
    vpc_id = var.vpc_id
}

module "acm_certificate" {
    source = "./acm"
    
    domain_name = var.domain_name
    route_53_zone_id = var.route_53_zone_id
    project_name = var.project_name
    environment = var.environment
    managed_by = var.managed_by
}

module "frontend_alb" {
    source = "./alb/frontend"
    
    certificate_validation_arn = module.acm_certificate.certificate_validation_arn
    security_group_id = module.frontend_alb_sg.security_group_id
    certificate_arn = module.acm_certificate.certificate_arn
    public_subnet_ids = var.public_subnet_ids
    project_name = var.project_name
    environment = var.environment
    managed_by = var.managed_by
    vpc_id = var.vpc_id
}

# module "backend_alb_sg" {
#     source = "./vpc/sg/backend_alb"
    
#     project_name = var.project_name
#     environment = var.environment
#     managed_by = var.managed_by
#     vpc_id = var.vpc_id
# }

# module "backend_alb" {
#     source = "./alb/backend"
    
#     security_group_id = module.backend_alb_sg.security_group_id
#     public_subnet_ids = var.public_subnet_ids
#     environment = var.environment
#     project_name = var.project_name
#     managed_by = var.managed_by
#     vpc_id = var.vpc_id
# }

module "ecs_fargate_sg" {
    source = "./vpc/sg/ecs_fargate"
    
    project_name = var.project_name
    environment = var.environment
    managed_by = var.managed_by
    vpc_id = var.vpc_id
}

module "landing_service" {
    source = "./ecs/services"
    
    container_name = var.ecs_landing_task_definition_container_name
    security_group_id = module.ecs_fargate_sg.security_group_id
    load_balancer_listener = module.frontend_alb.listener_arn
    target_group_arn = module.frontend_alb.target_group_arn
    task_definition_name = var.landing_task_definition_name
    task_definition_arn = var.landing_task_definition_arn
    private_subnet_ids = var.ecs_private_subnet_ids
    ecs_cluster_name = var.ecs_cluster_name
    project_name = var.project_name
    environment = var.environment
    managed_by = var.managed_by
}

module "nat_gateway" {
    source = "./vpc/nat"
    
    public_subnet_id = var.public_subnet_ids[0]
    project_name     = var.project_name
    environment      = var.environment
    managed_by       = var.managed_by
}

module "route53_record" {
    source = "./route53/records/alb"
    
    alb_dns_name     = module.frontend_alb.alb_dns_name
    alb_zone_id      = module.frontend_alb.zone_id
    route_53_zone_id = var.route_53_zone_id
    domain_name      = var.domain_name
}