variable "module_name" {
  type        = string
  description = "module name"
}

variable "ecs_cluster_id" {
  type        = string
  description = "Attach to existing cluster"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "desired_count" {
  type    = number
  default = 1
}

variable "ecs_task_definition" {
  type = object({
    family = string
    arn    = string
  })
}

variable "lb_config" {
  type = object({
    target_group_arn = string
    container_name   = string
    container_port   = number
  })
}

