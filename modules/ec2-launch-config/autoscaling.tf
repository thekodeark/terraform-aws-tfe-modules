resource "aws_autoscaling_group" "ecs-cluster" {
  name                 = aws_launch_configuration.ecs.name
  min_size             = var.ecs_scaling_config.min_capacity
  max_size             = var.ecs_scaling_config.max_capacity
  desired_capacity     = var.ecs_scaling_config.desired_capacity
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.ecs.name
  vpc_zone_identifier  = var.private_subnets

  lifecycle {
    create_before_destroy = true
  }
}