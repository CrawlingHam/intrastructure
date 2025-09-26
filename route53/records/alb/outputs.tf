output "zone_id" {
    description = "The zone ID of the Route 53 record"
    value       = aws_route53_record.main.zone_id
}