data "aws_availability_zones" "available" {
  state = "available"
}

module "networking" {
  source             = "./modules/networking"
  module_name        = "z-server"
  environment        = "dev"
  cidr               = "10.10.0.0/16"
  public_subnets     = ["10.10.100.0/24", "10.10.101.0/24"]
  private_subnets    = ["10.10.0.0/24", "10.10.1.0/24"]
  availability_zones = data.aws_availability_zones.available.names
}

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

module "security_group_service" {
  source = "./modules/security-group"
  security_config = {
    vpc_id      = module.networking.vpc.id
    module_name = "z-server-service"
    environment = "dev"
    ingress = [
      {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = null
        ipv6_cidr_blocks = null
        security_groups  = [module.security_group_lb.id]
      }
    ]
    egress = [
      {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = null
        ipv6_cidr_blocks = null
        security_groups  = [module.security_group_lb.id]
      }
    ]
  }
}

module "ecr" {
  source      = "./modules/ecr"
  module_name = "z-server"
  environment = "dev"
}

module "cert" {
  source      = "./modules/cert"
  fqdn        = "test.kodeark.com"
  hosted_zone = "kodeark.com"
}

# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html
module "ecs" {
  source      = "./modules/ecs"
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
    memory    = 1024
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
      host_path = "/ecs/service-storage"
    }
  }
  ec2_config = {
    security_group_ids = [module.security_group_service.id]
    instance_type      = "t2.micro"
    public_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
    root_block_device = {
      delete_on_termination = "true"
      volume_size           = "30"
      volume_type           = "gp2"
    }
  }
}