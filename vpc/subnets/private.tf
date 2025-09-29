resource "aws_subnet" "private" {
    count = length(var.availability_zones)

    cidr_block        = var.private_subnet_cidrs[count.index]
    availability_zone = var.availability_zones[count.index]
    vpc_id            = var.vpc_id

    tags = merge(local.common_tags, {
        Name = "${var.project_name}-private-subnet-${count.index + 1}-${var.environment}"
        Type = "Private"
    })
}