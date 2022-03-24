resource "aws_security_group" "this" {
  name        = var.security_config.module_name
  description = "Security group for ${var.security_config.module_name}-${var.security_config.environment}"
  vpc_id      = var.security_config.vpc_id

  dynamic "ingress" {
    for_each = var.security_config.ingress
    content {
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = lookup(ingress.value, "cidr_blocks", null)
      ipv6_cidr_blocks = lookup(ingress.value, "ipv6_cidr_blocks", null)
      security_groups  = lookup(ingress.value, "security_groups", null)
    }
  }

  dynamic "egress" {
    for_each = var.security_config.egress
    content {
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      cidr_blocks      = lookup(egress.value, "cidr_blocks", null)
      ipv6_cidr_blocks = lookup(egress.value, "ipv6_cidr_blocks", null)
      security_groups  = lookup(egress.value, "security_groups", null)
    }
  }
  tags = {
    Name        = "${var.security_config.module_name}-sg"
    Environment = var.security_config.environment
  }
  lifecycle {
    create_before_destroy = true
  }
}