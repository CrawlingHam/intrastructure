variable "project_name" {
    type = string
}

variable "environment" {
    type = string
}

variable "managed_by" {
    type = string
}

variable "vpc_cidr" {
    default     = "10.0.0.0/16"
    type        = string
}

variable "availability_zones" {
    default     = ["eu-north-1a", "eu-north-1b"]
    type        = list(string)
}

variable "public_subnet_cidrs" {
    default     = ["10.0.1.0/24", "10.0.2.0/24"]
    type        = list(string)
}

variable "private_subnet_cidrs" {
    default     = ["10.0.11.0/24", "10.0.12.0/24"]
    type        = list(string)
}

variable "alb_cidr_blocks" {
    description = "CIDR blocks for frontend ALB security groups"
    default = ["0.0.0.0/0"]
    type = list(string)
}

variable "ecs_fargate_ingress_from_port" {
    type = number
}

variable "ecs_fargate_ingress_to_port" {
    type = number
}

locals {
    common_tags = {
        Environment = var.environment
        Project     = var.project_name
        ManagedBy   = var.managed_by
    }
}
