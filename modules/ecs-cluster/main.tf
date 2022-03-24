resource "aws_ecs_cluster" "this" {
  name = "${var.module_name}-${var.environment}-cluster"

  tags = {
    Name        = "${var.module_name}-ecs"
    Environment = var.environment
  }
}
