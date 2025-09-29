variable "project_name" {
    type = string
}

variable "environment" {
    type = string
}

variable "region" {
    type = string
}

variable "common_tags" {
    type        = map(string)
    default     = {}
}
