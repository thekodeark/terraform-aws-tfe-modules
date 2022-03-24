resource "aws_lb" "this" {
  name               = "${var.module_name}-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = tolist([var.public_security_group])

  tags = {
    Name        = "${var.module_name}-alb"
    Environment = var.environment
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "this" {
  name     = "${var.module_name}-${var.environment}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    healthy_threshold   = var.lb_health_check_config.healthy_threshold
    interval            = var.lb_health_check_config.interval
    protocol            = var.lb_health_check_config.protocol
    matcher             = var.lb_health_check_config.matcher
    timeout             = var.lb_health_check_config.timeout
    path                = var.lb_health_check_config.path
    unhealthy_threshold = var.lb_health_check_config.unhealthy_threshold
  }

  tags = {
    Name        = "${var.module_name}-lb-tg"
    Environment = var.environment
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.id
  port              = "443"
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.this.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_route53_record" "this" {
  zone_id = var.zone_id
  name    = var.fqdn
  type    = "A"
  alias {
    name                   = aws_lb.this.dns_name
    zone_id                = aws_lb.this.zone_id
    evaluate_target_health = true
  }
}