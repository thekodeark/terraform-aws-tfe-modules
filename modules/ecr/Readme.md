ECR Module
===========

A terraform module to create Elastic Container Registry

Module Input Variables
----------------------

| Name   |      Requied      |  Description |
|----------|:-------------:|------:|
| module_name |  yes | An unique name of module |
| environment |  yes | An environment to deploy on |

Usage
-----

```hcl
module "ecr" {
  source      = "./modules/ecr"
  module_name = "z-server"
  environment = "dev"
}
```


Outputs
=======

 - `url` - ECR repository url

