variable "project_name" {
    type = string
}

variable "environment" {
    type = string
}

variable "managed_by" {
    type = string
}

variable "public_hosted_zone_domain" {
    type = string
}

variable "public_hosted_zone_name" {
    type = string
}

locals {
    common_tags = {
        Environment = var.environment
        Project = var.project_name
        ManagedBy = var.managed_by
    }
}
