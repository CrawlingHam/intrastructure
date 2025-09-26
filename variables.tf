variable "environment" {
    description = "The environment to deploy the frontend ALB to"
    default = "production"
    type = string
}

variable "project_name" {
    description = "The name of the project"
    default = "flixburst"
    type = string
}

variable "managed_by" {
    description = "The name of the person or team responsible for managing the project"
    default = "Flixburst"
    type = string
}

variable "public_subnet_ids" {
    description = "The public subnets to deploy the Application Load Balancer to"
    type = list(string)
}

variable "vpc_id" {
    description = "The VPC ID to deploy the ALB to"
    type = string
}

variable "landing_task_definition_name" {
    description = "The name of the landing page task definition"
    type = string
}

variable "landing_task_definition_arn" {
    description = "The ARN of the landing page task definition"
    type = string
}

variable "ecs_cluster_name" {
    description = "The name of the ECS cluster"
    type = string
}

variable "ecs_landing_task_definition_container_name" {
    description = "The name of the landing task definition container"
    type = string
}

variable "ecs_private_subnet_ids" {
    description = "The private subnets for ECS Fargate tasks"
    type = list(string)
}

variable "route_53_zone_id" {
    description = "The Route 53 hosted zone ID"
    type        = string
}

variable "domain_name" {
    description = "The domain name for the Route 53 record"
    type        = string
}