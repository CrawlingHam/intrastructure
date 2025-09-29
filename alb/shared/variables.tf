variable "project_name" {
    type = string
}

variable "environment" {
    type = string
}

variable "managed_by" {
    type = string
}

variable "alb_name" {
    type = string
}

variable "security_group_id" {
    type = string
}

variable "public_subnet_ids" {
    type = list(string)
}

variable "access_logs_bucket" {
    type = string
}

variable "enable_access_logs" {
    type = bool
}

variable "target_group_name" {
    type = string
}

variable "target_port" {
    type = number
}

variable "vpc_id" {
    type = string
}

variable "certificate_arn" {
    type = string
}

locals {
    common_tags = {
        Environment = var.environment
        Project     = var.project_name
        ManagedBy   = var.managed_by
    }
}
