resource "aws_eip" "nat" {
    domain = "vpc"
    
    tags = merge(local.common_tags, {
        Name = "nat-eip-${var.environment}"
    })
}

resource "aws_nat_gateway" "main" {
    subnet_id     = var.public_subnet_id
    allocation_id = aws_eip.nat.id
    
    tags = merge(local.common_tags, {
        Name = "nat-gateway-${var.environment}"
    })
    
    depends_on = [aws_eip.nat]
}