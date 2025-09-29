variable "project_name" {}
variable "environment" {}
variable "managed_by" {}

variable "route53_acm_domain_name" {
    description = "The domain name for the flixburst SSL certificate"
    type        = string
}

variable "route53_acm_zone_id" {
    description = "The Route 53 hosted zone ID for flixburst certificate validation"
    type        = string
}

locals {
    common_tags = {
        Environment = var.environment
        Project = var.project_name
        ManagedBy = var.managed_by
    }
}