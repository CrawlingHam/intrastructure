variable "environment" {}
variable "vpc_id" {}
variable "project_name" {}
variable "managed_by" {}

variable "alb_cidr_blocks" {
    description = "CIDR blocks for ALB security groups"
    default = ["0.0.0.0/0"]
    type = list(string)
}

locals {
    common_tags = {
        Environment = var.environment
        Project = var.project_name
        ManagedBy = var.managed_by
    }
}
