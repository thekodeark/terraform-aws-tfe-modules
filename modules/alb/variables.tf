variable "module_name" {
  type        = string
  description = "module name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of subnets to be associated with load balancer"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to associate with load balancer"
}

variable "public_security_group" {
  type        = string
  description = "security group for load balancer"
}

variable "lb_health_check_config" {
  description = "Health check configuration details of load balancer"
  type = object({
    healthy_threshold   = string
    interval            = string
    protocol            = string
    matcher             = string
    timeout             = string
    path                = string
    unhealthy_threshold = string
    port                = number
  })
  default = {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/ping/"
    unhealthy_threshold = "2"
    port                = 80
  }
}

variable "certificate_arn" {
  type = string
}

variable "fqdn" {
  type        = string
  description = "Fully qualified domain name for load balancer"
}

variable "zone_id" {
  type        = string
  description = "Route53 hosted zone id"
}

