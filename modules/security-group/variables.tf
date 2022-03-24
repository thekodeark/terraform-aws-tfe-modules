variable "security_config" {
  type = object({
    module_name = string
    environment = string
    vpc_id      = string
    ingress = list(object({
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = list(string)
      ipv6_cidr_blocks = list(string)
      security_groups  = list(string)
    }))
    egress = list(object({
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = list(string)
      ipv6_cidr_blocks = list(string)
      security_groups  = list(string)
    }))
  })
}