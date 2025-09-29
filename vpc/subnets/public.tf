resource "aws_subnet" "public" {
    count = length(var.availability_zones)

    cidr_block              = var.public_subnet_cidrs[count.index]
    availability_zone       = var.availability_zones[count.index]
    vpc_id                  = var.vpc_id
    map_public_ip_on_launch = true

    tags = merge(local.common_tags, {
        Name = "${var.project_name}-public-subnet-${count.index + 1}-${var.environment}"
        Type = "Public"
    })
}