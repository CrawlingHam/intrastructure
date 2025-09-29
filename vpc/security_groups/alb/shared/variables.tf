variable "project_name" {
    type = string
}

variable "environment" {
    type = string
}

variable "managed_by" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "http_ingress_cidr_blocks" {
    type = list(string)
}

variable "https_ingress_cidr_blocks" {
    type = list(string)
}

variable "egress_cidr_blocks" {
    type = list(string)
}

variable "alb_name" {
    type = string
}

variable "description" {
    type = string
}

locals {
    common_tags = {
        Environment = var.environment
        Project = var.project_name
        ManagedBy = var.managed_by
    }
}
