# VPC
resource "aws_vpc" "main" {
    cidr_block           = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support   = true

    tags = merge(local.common_tags, {
        Name = "${var.project_name}-vpc-${var.environment}"
    })
}

module "subnets" {
    source = "./subnets"
    
    private_subnet_cidrs  = var.private_subnet_cidrs
    public_subnet_cidrs   = var.public_subnet_cidrs
    availability_zones    = var.availability_zones
    vpc_id                = aws_vpc.main.id
    
    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
}

module "elastic_ips" {
    source = "./eip"
    
    availability_zones = var.availability_zones
    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
}

module "gateways" {
    source = "./gateways"
    
    public_subnet_ids = module.subnets.public_subnet_ids
    availability_zones = var.availability_zones
    eip_ids = module.elastic_ips.nat_eip_ids
    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
    vpc_id = aws_vpc.main.id
}

module "route_tables" {
    source = "./route_tables"
    
    internet_gateway_id = module.gateways.internet_gateway_id
    private_subnet_ids = module.subnets.private_subnet_ids
    public_subnet_ids = module.subnets.public_subnet_ids
    nat_gateway_ids = module.gateways.nat_gateway_ids
    availability_zones = var.availability_zones
    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
    vpc_id = aws_vpc.main.id
}