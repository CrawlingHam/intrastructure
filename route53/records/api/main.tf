resource "aws_route53_record" "api" {
    name      = "api.${var.domain_name}"
    zone_id   = var.route_53_zone_id
    type      = "A"

    alias {
        name                   = var.alb_dns_name
        zone_id                = var.alb_zone_id
        evaluate_target_health = true
    }
}
