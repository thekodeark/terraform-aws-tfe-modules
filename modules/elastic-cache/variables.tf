variable "module_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "node_type" {
  type    = string
  default = "cache.m4.large"
}

variable "num_cache_nodes" {
  type    = number
  default = 1
}

variable "parameter_group_name" {
  type    = string
  default = "default.redis3.2"
}

variable "engine_version" {
  type    = string
  default = "3.2.10"
}

variable "port" {
  type    = number
  default = 6379
}

variable "security_group_ids" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "maintenance_window" {
  type    = string
  default = "Mon:00:00-Mon:03:00"
}

#variable "db_config" {
#  type = object({
#    userid    = string
#    username  = string
#    port      = number
#    passwords = list(string)
#    no_password_required = bool
#  })
#  validation {
#    condition     = lower(var.db_config.username) != "user"
#    error_message = "user is not a valid username"
#  }
#}