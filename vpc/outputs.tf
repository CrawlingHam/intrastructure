output "vpc_id" {
    value       = aws_vpc.main.id
}

# output "vpc_cidr_block" {
#     description = "CIDR block of the VPC"
#     value       = aws_vpc.main.cidr_block
# }

# output "internet_gateway_id" {
#     description = "ID of the Internet Gateway"
#     value       = module.internet_gateway.gateway_id
# }

# output "public_subnet_ids" {
#     description = "IDs of the public subnets"
#     value       = module.subnets.public_subnet_ids
# }

# output "private_subnet_ids" {
#     description = "IDs of the private subnets"
#     value       = module.subnets.private_subnet_ids
# }

# output "public_subnet_cidrs" {
#     description = "CIDR blocks of the public subnets"
#     value       = module.subnets.public_subnet_cidrs
# }

# output "private_subnet_cidrs" {
#     description = "CIDR blocks of the private subnets"
#     value       = module.subnets.private_subnet_cidrs
# }

# output "nat_gateway_ids" {
#     description = "IDs of the NAT Gateways"
#     value       = module.nat_gateways[*].gateway_id
# }

# output "public_route_table_id" {
#     description = "ID of the public route table"
#     value       = module.route_tables.public_route_table_id
# }

# output "private_route_table_ids" {
#     description = "IDs of the private route tables"
#     value       = module.route_tables.private_route_table_ids
# }
