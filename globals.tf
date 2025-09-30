variable "environment" {
    default = "production"
    type = string
}

variable "project_name" {
    default = "flixburst"
    type = string
}

variable "managed_by" {
    default = "Flixburst"
    type = string
}

variable "region" {
    default = "eu-north-1"
    type = string
}

variable "frontend_alb_target_port" {
    type = number
    default = 3000
}

variable "backend_alb_target_port" {
    type = number
    default = 3000
}
