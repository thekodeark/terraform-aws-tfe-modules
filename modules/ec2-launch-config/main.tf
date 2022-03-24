data "aws_ami" "amazon_linux" {

  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }

  owners = ["amazon"]
}

resource "aws_key_pair" "this" {
  key_name_prefix = "${var.module_name}-ec2-"
  public_key      = var.ec2_config.public_key
}

resource "aws_launch_configuration" "ecs" {
  name_prefix                 = "${var.module_name}-cluster--"
  image_id                    = data.aws_ami.amazon_linux.id
  instance_type               = var.ec2_config.instance_type
  security_groups             = var.ec2_config.security_group_ids
  iam_instance_profile        = aws_iam_instance_profile.ecs_ec2_profile.name
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = false

  user_data = <<EOF
    #!/bin/bash
    echo "ECS_CLUSTER=${var.ecs_cluster_name}" >> /etc/ecs/ecs.config
  EOF

  lifecycle {
    create_before_destroy = true
  }
}