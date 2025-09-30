resource "aws_iam_role" "ecs_task_execution" {
    name = "AWSECSTaskExecutionRole"

    assume_role_policy  = jsonencode({
        Version         = "2012-10-17",
        Statement = [
            {
                Sid    = "AllowECSTasksToAssumeRole"
                Action = "sts:AssumeRole"
                Effect = "Allow",
                Principal = {
                    Service = "ecs-tasks.amazonaws.com"
                },
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
    role       = aws_iam_role.ecs_task_execution.name
    depends_on = [ aws_iam_role.ecs_task_execution ]
}