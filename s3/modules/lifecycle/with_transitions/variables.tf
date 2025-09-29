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

variable "expiration_days" {
    type = number
    default = 90
}

variable "transition_days_ia" {
    type = number
    default = 30
}

variable "transition_days_glacier" {
    type = number
    default = 60
}

variable "noncurrent_days" {
    type = number
    default = 7
}

variable "days_after_initiation" {
    type = number
    default = 7
}
