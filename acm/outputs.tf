output "route53_certificate_arn" {
    description = "The ARN of the ACM certificate for flixburst.com"
    value       = aws_acm_certificate.route53_acm_certificate.arn
}

output "route53_certificate_domain_name" {
    description = "The domain name of the flixburst certificate"
    value       = aws_acm_certificate.route53_acm_certificate.domain_name
}

output "route53_certificate_status" {
    description = "The status of the flixburst certificate"
    value       = aws_acm_certificate.route53_acm_certificate.status
}

output "route53_certificate_validation_arn" {
    description = "The ARN of the flixburst certificate validation resource"
    value       = aws_acm_certificate_validation.route53_acm_certificate_validation.certificate_arn
}
