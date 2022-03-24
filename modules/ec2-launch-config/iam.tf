// Allow EC2 instance to register as ECS ecs-service-cluster member, fetch ECR images, write logs to CloudWatch
data "aws_iam_policy_document" "ec2_instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "ec2" {
  assume_role_policy = data.aws_iam_policy_document.ec2_instance_assume_role_policy.json
  name               = "EcsCluster${var.module_name}Ec2InstanceRole"
  tags = {
    Name        = "${var.module_name}-ec2"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ssm_core_role" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ecs_ec2_profile" {
  name = "EcsCluster${var.module_name}Ec2InstanceProfile"
  role = aws_iam_role.ec2.name
}