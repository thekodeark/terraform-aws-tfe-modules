Networking Module
===========

A terraform module to create virtual network in AWS

Module Input Variables
----------------------

| Name   |      Requied      |  Description |
|----------|:-------------:|------:|
| module_name |  yes | An unique name of module |
| environment |  yes | An environment to deploy on |
| cidr |  no | Internet Protocol (IP) addresses |
| public_subnets |  no | Internet Protocol (IP) addresses |
| private_subnets |  no | Internet Protocol (IP) addresses |
| availability_zones |  no | Data Centers Location |

Usage
-----

```hcl
module "networking" {
  source             = "./modules/networking"
  module_name        = "z-server"
  environment        = "dev"
  cidr               = "10.10.0.0/16"
  public_subnets     = ["10.10.100.0/24", "10.10.101.0/24"]
  private_subnets    = ["10.10.0.0/24", "10.10.1.0/24"]
  availability_zones = data.aws_availability_zones.available.names
}
```


Outputs
=======

 - `vpc` - An object contains `{id, arn}`
 - `igw` - An object contains `{id, arn}`
 - `public_subnets` - A list contains `[id]`
 - `private_subnets` - A list contains `[id]`

