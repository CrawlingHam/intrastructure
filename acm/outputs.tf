output "certificate_arn" {
    description = "The ARN of the ACM certificate"
    value       = aws_acm_certificate.main.arn
}

output "certificate_domain_name" {
    description = "The domain name of the certificate"
    value       = aws_acm_certificate.main.domain_name
}

output "certificate_status" {
    description = "The status of the certificate"
    value       = aws_acm_certificate.main.status
}

output "certificate_validation_arn" {
    description = "The ARN of the certificate validation resource"
    value       = aws_acm_certificate_validation.main.certificate_arn
}
