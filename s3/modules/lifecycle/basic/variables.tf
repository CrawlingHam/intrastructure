variable "bucket_id" {
    type = string
}

variable "rule_id" {
    type = string
}

variable "prefix" {
    type = string
    default = ""
}

variable "noncurrent_days" {
    type = number
    default = 30
}

variable "days_after_initiation" {
    type = number
    default = 7
}
