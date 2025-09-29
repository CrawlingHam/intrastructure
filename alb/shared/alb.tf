resource "aws_lb" "alb" {
    name                    = "${var.alb_name}-${var.environment}"
    security_groups         = [var.security_group_id]
    subnets                 = var.public_subnet_ids
    load_balancer_type      = "application"
    enable_cross_zone_load_balancing = true
    
    access_logs {
        bucket  = var.access_logs_bucket
        enabled = var.enable_access_logs
    }

    tags = local.common_tags
}