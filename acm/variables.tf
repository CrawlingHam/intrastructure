variable "domain_name" {
    description = "The domain name for the SSL certificate"
    type        = string
}

variable "route_53_zone_id" {
    description = "The Route 53 hosted zone ID for certificate validation"
    type        = string
}

variable "project_name" {}
variable "environment" {}
variable "managed_by" {}

locals {
    common_tags = {
        Environment = var.environment
        Project = var.project_name
        ManagedBy = var.managed_by
    }
}