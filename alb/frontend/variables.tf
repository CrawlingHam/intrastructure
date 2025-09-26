variable "certificate_validation_arn" {}
variable "security_group_id" {}
variable "public_subnet_ids" {}
variable "certificate_arn" {}
variable "project_name" {}
variable "environment" {}
variable "managed_by" {}
variable "vpc_id" {}

locals {
     common_tags = {
        Environment = var.environment
        Project = var.project_name
        ManagedBy = var.managed_by
    }
}
