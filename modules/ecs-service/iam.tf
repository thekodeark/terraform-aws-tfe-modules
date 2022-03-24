// Allow ECS service to interact with LoadBalancers
data "aws_iam_policy_document" "ecs_service_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs" {
  assume_role_policy = data.aws_iam_policy_document.ecs_service_role_policy.json
  name               = "EcsCluster${var.module_name}ServiceRole"
  tags = {
    Name        = "${var.module_name}-ecs"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "ecs" {
  role       = aws_iam_role.ecs.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}