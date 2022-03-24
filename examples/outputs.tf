output "networking" {
  value = {
    vpc             = module.networking.vpc
    igw             = module.networking.igw
    public_subnets  = module.networking.public_subnets
    private_subnets = module.networking.private_subnets
  }
}

output "security_group_lb" {
  value = module.security_group_lb
}

output "security_group_service" {
  value = module.security_group_service
}

output "ecr" {
  value = module.ecr
}

# output "cloudwatch_logs" {
#   value = module.cloudwatch_logs
# }

# output "rds" {
#   value = module.rds
# }

# output "elastic_cache" {
#   value = module.elastic_cache
# }