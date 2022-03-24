variable "module_name" {
  type        = string
  description = "module name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "container_definition" {
  type = list(object({
    name   = string
    image  = string
    cpu    = number
    memory = number
    links  = list(string)
    portMappings = list(object({
      containerPort = number
      hostPort      = number
      protocol      = string
    }))
    command = list(string)
    environment = list(object({
      name  = string
      value = string
    }))
    logConfiguration = object({
      logDriver = string,
      options = object({
        awslogs-group  = string
        awslogs-region = string
      })
    })
  }))
  description = "Container definition overrides which allows for extra keys or overriding existing keys."
}