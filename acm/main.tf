resource "aws_acm_certificate" "main" {
    domain_name       = var.domain_name
    validation_method = "DNS"
    
    subject_alternative_names = [
        "www.${var.domain_name}",
        "api.${var.domain_name}"
    ]
    
    tags = merge(local.common_tags, {
        Name = "ssl-cert-${var.environment}"
    })
}

resource "aws_route53_record" "cert_validation" {
    for_each = {
        for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
            record = dvo.resource_record_value
            name   = dvo.resource_record_name
            type   = dvo.resource_record_type
        }
    }
    
    zone_id         = var.route_53_zone_id
    records         = [each.value.record]
    name            = each.value.name
    type            = each.value.type
    allow_overwrite = true
    ttl             = 60
}

resource "aws_acm_certificate_validation" "main" {
    certificate_arn         = aws_acm_certificate.main.arn
    validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}