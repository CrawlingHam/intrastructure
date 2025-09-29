output "public_zone_id" {
    description = "Route53 public hosted zone ID"
    value       = aws_route53_zone.public_hosted_zone.zone_id
}

output "public_name_servers" {
    description = "Name servers for the public hosted zone"
    value       = aws_route53_zone.public_hosted_zone.name_servers
}
