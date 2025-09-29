resource "aws_eip" "nat" {
    count = length(var.availability_zones)
    domain = "vpc"

    tags = merge(local.common_tags, {
        Name = "${var.project_name}-nat-eip-${count.index + 1}-${var.environment}"
    })

}