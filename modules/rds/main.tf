resource "aws_db_subnet_group" "this" {

  name        = lower(format("%s-%s", var.module_name, "db-subnet-group"))
  description = "Database subnet group for ${var.module_name}"
  subnet_ids  = var.subnet_ids

  tags = {
    Name        = "${var.module_name}-db-subnet-group"
    Environment = var.environment
  }
}

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.module_name}-rds"

  create_db_option_group    = false
  create_db_parameter_group = false

  engine               = var.db_instance_config.engine
  engine_version       = var.db_instance_config.engine_version
  family               = var.db_instance_config.family
  major_engine_version = var.db_instance_config.major_engine_version
  instance_class       = var.db_instance_config.instance_class

  allocated_storage = var.db_instance_config.allocated_storage

  db_name  = var.db_config.db_name
  username = var.db_config.username
  port     = var.db_config.port
  password = var.db_config.password

  multi_az = true

  db_subnet_group_name   = aws_db_subnet_group.this.id
  vpc_security_group_ids = tolist(var.security_group_ids)

  maintenance_window      = var.maintenance_window
  backup_window           = var.backup_window
  backup_retention_period = 0

  tags = {
    Name        = "${var.module_name}-rds"
    Environment = var.environment
  }
}