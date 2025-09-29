variable "project_name" {}
variable "environment" {}
variable "managed_by" {}

locals {
    common_tags = {
        Environment = var.environment
        Project = var.project_name
        ManagedBy = var.managed_by
    }
}
