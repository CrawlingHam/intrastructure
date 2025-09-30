resource "aws_vpc" "main" {
    cidr_block           = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support   = true

    tags = merge(local.common_tags, {
        Name = "${var.project_name}-vpc-${var.environment}"
    })
}

module "subnets" {
    private_subnet_cidrs  = var.private_subnet_cidrs
    public_subnet_cidrs   = var.public_subnet_cidrs
    availability_zones    = var.availability_zones
    vpc_id                = aws_vpc.main.id
    project_name          = var.project_name
    environment           = var.environment
    managed_by            = var.managed_by
    source                = "./subnets"
}

module "elastic_ips" {
    availability_zones  = var.availability_zones
    project_name        = var.project_name
    environment         = var.environment
    managed_by          = var.managed_by
    source              = "./eip"
}

module "gateways" {
    public_subnet_ids       = module.subnets.public_subnet_ids
    eip_ids                 = module.elastic_ips.nat_eip_ids
    availability_zones      = var.availability_zones
    project_name            = var.project_name
    environment             = var.environment
    vpc_id                  = aws_vpc.main.id
    managed_by              = var.managed_by
    source                  = "./gateways"
}

module "route_tables" {
    internet_gateway_id     = module.gateways.internet_gateway_id
    private_subnet_ids      = module.subnets.private_subnet_ids
    public_subnet_ids       = module.subnets.public_subnet_ids
    nat_gateway_ids         = module.gateways.nat_gateway_ids
    availability_zones      = var.availability_zones
    project_name            = var.project_name
    environment             = var.environment
    source                  = "./route_tables"
    vpc_id                  = aws_vpc.main.id
    managed_by              = var.managed_by
}

module "security_groups" {
    alb_cidr_blocks = var.alb_cidr_blocks
    common_tags = local.common_tags
    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by
    source = "./security_groups"
    vpc_id = aws_vpc.main.id 

}
