output "api_record_name" {
    description = "The name of the API Route 53 record"
    value       = aws_route53_record.api.name
}
