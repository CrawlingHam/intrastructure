resource "aws_ecs_cluster" "main" {
  	name = "${var.project_name}-${var.environment}-cluster"

	setting {
		name  = "containerInsights"
		value = "enabled"
	}

 
  	tags = merge(local.common_tags, {
        Name = "${var.project_name}-${var.environment}-cluster"
    })
}

resource "aws_ecs_cluster_capacity_providers" "main" {
	capacity_providers = ["FARGATE", "FARGATE_SPOT"]
	cluster_name = aws_ecs_cluster.main.name

	default_capacity_provider_strategy {
		capacity_provider = "FARGATE"
		weight            = 100
		base              = 1
	}
}