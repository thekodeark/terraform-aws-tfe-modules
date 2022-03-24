module "sqs" {
  source  = "terraform-aws-modules/sqs/aws"
  version = ">= 3.3.0"

  name = "${var.module_name}-sqs"

  tags = {
    Name        = "${var.module_name}-sqs"
    Environment = var.environment
  }
}