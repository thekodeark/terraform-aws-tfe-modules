data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}
resource "aws_ecs_task_definition" "this" {
  family = "${var.module_name}-task"

  container_definitions = jsonencode(var.container_definition)
  execution_role_arn    = data.aws_iam_role.ecs_task_execution_role.arn
  tags = {
    Name        = "${var.module_name}-ecs-task"
    Environment = var.environment
  }
}