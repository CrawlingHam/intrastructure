variable "environment" {
    type = string
}

variable "common_tags" {
    type = map(string)
}

variable "vpc_id" {
    type = string
}

variable "alb_cidr_blocks" {
    type = list(string)
}

variable "ecs_fargate_ingress_from_port" {
    type = number
}

variable "ecs_fargate_ingress_to_port" {
    type = number
}
