variable "project_name" {
    type = string
}

variable "environment" {
    type = string
}

variable "managed_by" {
    type = string
}

variable "public_subnet_ids" {
    type = list(string)
}

variable "availability_zones" {
    type = list(string)
}

variable "private_subnet_ids" {
    type = list(string)
}

variable "vpc_id" {
    type = string
}

variable "nat_gateway_ids" {
    type = list(string)
}

variable "internet_gateway_id" {
    type = string
}

locals {
    common_tags = {
        Environment = var.environment
        Project     = var.project_name
        ManagedBy   = var.managed_by
    }
}
