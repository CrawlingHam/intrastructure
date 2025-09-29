resource "aws_nat_gateway" "main" {
    count = length(var.availability_zones)

    subnet_id     = var.public_subnet_ids[count.index]
    allocation_id = var.eip_ids[count.index]

    tags = merge(local.common_tags, {
        Name = "${var.project_name}-nat-gateway-${count.index + 1}-${var.environment}"
    })

    depends_on = [aws_internet_gateway.main]
}