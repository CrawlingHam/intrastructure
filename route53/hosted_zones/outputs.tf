output "public_hosted_zone_name" {
    value       = aws_route53_zone.public_hosted_zone.name
}

output "public_zone_id" {
    value       = aws_route53_zone.public_hosted_zone.zone_id
}
