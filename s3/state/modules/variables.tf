variable "project_name" {}
variable "environment" {}
variable "region" {}

variable "common_tags" {
    description = "Common tags to apply to all resources"
    type        = map(string)
    default     = {}
}
