variable "load_balancer_listener" {}
variable "task_definition_name" {}
variable "task_definition_arn" {}
variable "private_subnet_ids" {}
variable "security_group_id" {}
variable "target_group_arn" {}
variable "ecs_cluster_name" {}
variable "container_name" {}
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