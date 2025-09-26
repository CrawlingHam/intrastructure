resource "aws_ecs_service" "landing_app" {
    name                = "${var.task_definition_name}-${var.environment}-service"
    task_definition     = var.task_definition_arn
    cluster             = var.ecs_cluster_name
    launch_type         = "FARGATE"
    desired_count       = 1

    network_configuration {
        security_groups     = [var.security_group_id]
        subnets             = var.private_subnet_ids
        assign_public_ip    = false
    }

    load_balancer {
        target_group_arn = var.target_group_arn
        container_name = var.container_name
        container_port = 3000
    }

    depends_on = [ var.load_balancer_listener ]

    tags = local.common_tags
}