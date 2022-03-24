module "event-bridge" {
  source  = "terraform-aws-modules/eventbridge/aws"
  version = ">= 1.14.0"

  bus_name = "${var.module_name}-bus"

  rules = {
    orders = {
      event_pattern = jsonencode(var.event_pattern)
      enabled       = true
    }
  }

  targets = {
    orders = tolist(var.target_orders)
  }

  tags = {
    Name = "my-bus"
  }
}