# main.tf | Elastic Container Repository

resource "aws_ecr_repository" "this" {
  name = "${var.module_name}-ecr"
  tags = {
    Name        = "${var.module_name}-ecr"
    Environment = var.environment
  }
}
