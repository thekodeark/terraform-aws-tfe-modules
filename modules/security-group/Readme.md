Security Group Module
===========

A terraform module to create Security Groups

Module Input Variables
----------------------

| Name   |      Requied      |  Description |
|----------|:-------------:|------:|
| security_config |  yes | An object contains all the definition to create security. It includes inbound and outbound rule |

Usage
-----

```hcl
module "security_group_lb" {
  source = "./modules/security-group"
  security_config = {
    vpc_id      = module.networking.vpc.id
    module_name = "z-server-lb"
    environment = "dev"
    ingress = [
      {
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        security_groups  = null
      },
      {
        from_port        = 443
        to_port          = 443
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        security_groups  = null
      }
    ]
    egress = [
      {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        security_groups  = null
      }
    ]
  }
}
```


Outputs
=======

 - `id` - A string contains security group id`
