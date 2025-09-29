resource "aws_route53_zone" "public_hosted_zone" {
    name = var.public_hosted_zone_name

    tags = merge(local.common_tags, {
        Domain  = var.public_hosted_zone_domain
        Name    = var.public_hosted_zone_name
        Purpose = "Domain Management"
        Type    = "Public"
    })
}