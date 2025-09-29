variable "project_name" {
    type = string
}

variable "environment" {
    type = string
}

variable "managed_by" {
    type = string
}

locals {
    common_tags = {
        Project     = var.project_name
        Environment = var.environment
        ManagedBy   = var.managed_by
    }
}
