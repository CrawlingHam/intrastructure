variable "project_name" {
    type = string
}

variable "environment" {
    type = string
}

variable "managed_by" {
    type = string
}

variable "backend_security_group_id" {
    type = string
}

variable "frontend_security_group_id" {
    type = string
}

variable "public_subnet_ids" {
    type = list(string)
}

variable "vpc_id" {
    type = string
}

variable "certificate_arn" {
    type = string
}

variable "access_logs_bucket" {
    type    = string
    default = ""
}

variable "enable_access_logs" {
    type    = bool
    default = false
}

locals {
    common_tags = {
        Environment = var.environment
        Project     = var.project_name
        ManagedBy   = var.managed_by
    }
}
