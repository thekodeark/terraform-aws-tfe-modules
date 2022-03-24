variable "module_name" {
  type        = string
  description = "module name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "event_pattern" {
  type = map(any)
}

variable "target_orders" {
  type = list(any)
}