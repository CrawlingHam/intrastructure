resource "aws_route53_record" "frontend_alb_a_record" {
    name    = var.hosted_zone_name
    zone_id = var.hosted_zone_id
    type    = "A"
    
    alias {
        name                   = var.frontend_alb_dns_name
        zone_id                = var.frontend_alb_zone_id
        evaluate_target_health = true
    }
}

resource "aws_route53_record" "backend_alb_a_record" {
    name    = "api.${var.hosted_zone_name}"
    zone_id = var.hosted_zone_id
    type    = "A"
    
    alias {
        name                   = var.backend_alb_dns_name
        zone_id                = var.backend_alb_zone_id
        evaluate_target_health = true
    }
}