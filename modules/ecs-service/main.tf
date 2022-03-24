resource "aws_ecs_service" "this" {
  name            = "${var.module_name}-${var.environment}-ecs-service"
  cluster         = var.ecs_cluster_id
  task_definition = var.ecs_task_definition.arn
  desired_count   = var.desired_count
  iam_role        = aws_iam_role.ecs.arn

  load_balancer {
    target_group_arn = var.lb_config.target_group_arn
    container_name   = var.lb_config.container_name
    container_port   = var.lb_config.container_port
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}

