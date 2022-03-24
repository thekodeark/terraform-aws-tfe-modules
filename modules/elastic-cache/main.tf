resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.module_name}-redis-subnet"
  subnet_ids = tolist(var.subnet_ids)
  tags = {
    Name        = "${var.module_name}-redis-subnet"
    Environment = var.environment
  }
}

resource "aws_elasticache_cluster" "this" {
  cluster_id           = "${var.module_name}-cluster"
  engine               = "redis"
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = var.parameter_group_name
  engine_version       = var.engine_version
  port                 = var.port
  az_mode              = var.num_cache_nodes > 1 ? "cross-az" : "single-az"
  maintenance_window   = var.maintenance_window
  security_group_ids   = tolist(var.security_group_ids)
  subnet_group_name    = aws_elasticache_subnet_group.this.name
  tags = {
    Name        = "${var.module_name}-cluster"
    Environment = var.environment
  }
}

#resource "aws_elasticache_user" "this" {
#  user_id              = var.db_config.userid
#  user_name            = var.db_config.username
#  access_string        = "on ~app::* -@all +@read +@hash +@bitmap +@geo -setbit -bitfield -hset -hsetnx -hmset -hincrby -hincrbyfloat -hdel -bitop -geoadd -georadius -georadiusbymember"
#  engine               = "REDIS"
#  passwords            = var.db_config.no_password_required ? null : var.db_config.passwords
#  no_password_required = var.db_config.no_password_required
#}