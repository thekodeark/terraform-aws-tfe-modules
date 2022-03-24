variable "module_name" {
  type        = string
  description = "module name"
}
variable "environment" {
  type        = string
  description = "Environment"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of subnets to be associated with ECS"
}

variable "ecs_cluster_name" {
  type        = string
  description = "ECS Cluster name"
}

variable "ecs_scaling_config" {
  type = object({
    min_capacity     = number
    max_capacity     = number
    desired_capacity = number
  })

  default = {
    min_capacity     = 1
    max_capacity     = 2
    desired_capacity = 1
  }
}

variable "ec2_config" {
  type = object({
    security_group_ids = list(string)
    public_key         = string
    instance_type      = string
  })
  default = {
    security_group_ids = null
    instance_type      = "t2.micro"
    public_key         = ""
  }
}

