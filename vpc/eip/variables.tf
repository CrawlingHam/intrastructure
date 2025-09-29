variable "project_name" {
    type = string
}

variable "environment" {
    type = string
}

variable "managed_by" {
    type = string
}

variable "availability_zones" {
    type = list(string)
}

locals {
    common_tags = {
        Environment = var.environment
        Project     = var.project_name
        ManagedBy   = var.managed_by
    }
}
