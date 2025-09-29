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
