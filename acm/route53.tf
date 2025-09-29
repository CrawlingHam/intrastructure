resource "aws_acm_certificate" "route53_acm_certificate" {
    domain_name       = var.route53_acm_domain_name
    validation_method = "DNS"
    
    subject_alternative_names = [
        "www.${var.route53_acm_domain_name}",
        "api.${var.route53_acm_domain_name}"
    ]
    
    tags = merge(local.common_tags, {
        Name = "ssl-cert-${var.environment}"
    })
}

resource "aws_route53_record" "route53_cert_validation" {
    for_each = {
        for dvo in aws_acm_certificate.route53_acm_certificate.domain_validation_options : dvo.domain_name => {
            record = dvo.resource_record_value
            name   = dvo.resource_record_name
            type   = dvo.resource_record_type
        }
    }
    
    zone_id         = var.route53_acm_zone_id
    records         = [each.value.record]
    name            = each.value.name
    type            = each.value.type
    allow_overwrite = true
    ttl             = 60
}

resource "aws_acm_certificate_validation" "route53_acm_certificate_validation" {
    certificate_arn         = aws_acm_certificate.route53_acm_certificate.arn
    validation_record_fqdns = [for record in aws_route53_record.route53_cert_validation : record.fqdn]
}