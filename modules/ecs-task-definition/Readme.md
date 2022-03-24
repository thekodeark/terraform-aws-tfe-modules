ECS Module
===========

A terraform module to create ECS module and deploy docker service

Module Input Variables
----------------------

| Name   |      Requied      |  Description |
|----------|:-------------:|------:|
| module_name |  yes | An unique name of module |
| environment |  yes | An environment to deploy on |
| public_subnets |  yes | A subnet that's associated with a route table that has a route to an internet gateway |
| private_subnets |  yes | A subnet are back-end servers that don't need to accept incoming traffic from the internet and therefore do not have public IP addresses |
| vpc_id |  yes | A vritual private network where all the services will be deployed |
| public_security_group |  yes | Security group which will allow incoming traffic from out world |
| private_security_group |  yes | Security group which will not be accessible by outer world |
| lb_health_check_config |  no | Load balance health check config |
| certificate_arn |  yes | ARN of certificate |
| fqdn |  yes | Fully qualified domain to link load balancer to domain name |
| service_definition |  no | A configuration to launch the service definition using task definition |
| container_definition |  yes | A docker container definition |
| ecs_scaling_config |  no | An auto scaling configuration |

Usage
-----

```hcl
module "ecs" {
  source      = "./modules/ecs-service"
  module_name = "z-server"
  environment = "dev"

  public_subnets         = module.networking.public_subnets
  private_subnets        = module.networking.private_subnets
  vpc_id                 = module.networking.vpc.id
  zone_id                = module.cert.zone_id
  public_security_group  = module.security_group_lb.id
  private_security_group = module.security_group_service.id
  certificate_arn        = module.cert.arn
  fqdn                   = "test.kodeark.com"
  container_definition = {
    name      = "nginx"
    image     = join(":", ["nginx", "latest"])
    cpu       = 512
    memory    = 512
    essential = true
    portMappings = {
      containerPort = 80
      hostPort      = 80
    }
    environment = [{
      name  = "PG_USER"
      value = "ASHUTOSH"
    }]
    volume = {
      name      = "service-storage"
      host_path = "/ecs-service/service-storage"
    }
  }
}
```


Outputs
=======

 - `url` - ECR repository url

