variable "project_name" {
    type = string
}

variable "environment" {
    type = string
}

variable "managed_by" {
    type = string
}

variable "certificate_arn" {
    type = string
}

variable "alb_arn" {
    type = string
}

variable "target_group_arn" {
    type = string
}

locals {
    common_tags = {
        Environment = var.environment
        Project     = var.project_name
        ManagedBy   = var.managed_by
    }
}
