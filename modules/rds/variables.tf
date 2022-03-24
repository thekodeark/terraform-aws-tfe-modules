variable "module_name" {
  type        = string
  description = "module name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "maintenance_window" {
  type    = string
  default = "Mon:00:00-Mon:03:00"
}

variable "backup_window" {
  type    = string
  default = "03:00-06:00"
}

variable "db_config" {
  type = object({
    db_name  = string
    username = string
    port     = number
    password = string
  })
  validation {
    condition     = lower(var.db_config.username) != "user"
    error_message = "Username can not be as user."
  }
}

variable "db_instance_config" {
  type = object({
    engine               = string
    engine_version       = string
    family               = string
    major_engine_version = string
    instance_class       = string
    allocated_storage    = number
  })
  default = {
    engine               = "postgres"
    engine_version       = "14.1"
    family               = "postgres14"
    major_engine_version = "14"
    allocated_storage    = 20
    instance_class       = "db.t4g.small"
  }
}