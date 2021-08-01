################################
# RDS
################################
# Subnet group
resource "aws_db_subnet_group" "this" {
  name = "${var.env}-${var.project}-db-subnet"

  subnet_ids = aws_subnet.private.*.id
}

# Parameter group
resource "aws_db_parameter_group" "this" {
  name   = "${var.env}-${var.project}-parameter-group"
  family = "mysql8.0"

  parameter {
    name         = "general_log"
    value        = "1"
    apply_method = "immediate"
  }

  parameter {
    name         = "slow_query_log"
    value        = "1"
    apply_method = "immediate"
  }

  parameter {
    name         = "long_query_time"
    value        = "0"
    apply_method = "immediate"
  }

  parameter {
    name         = "log_output"
    value        = "FILE"
    apply_method = "immediate"
  }
}

# Option group
resource "aws_db_option_group" "this" {
  name                 = "${var.env}-${var.project}-option-group"
  engine_name          = "mysql"
  major_engine_version = "8.0"
}

# DB Instance
resource "aws_db_instance" "this" {
  engine                              = "mysql"
  engine_version                      = "8.0.20"
  license_model                       = "general-public-license"
  identifier                          = "${var.env}-${var.project}-db-instance"
  username                            = var.db_user_name
  password                            = var.db_user_password
  instance_class                      = var.db_instance_class
  storage_type                        = "gp2"
  allocated_storage                   = 20
  max_allocated_storage               = 100
  multi_az                            = false
  db_subnet_group_name                = aws_db_subnet_group.this.name
  publicly_accessible                 = false
  vpc_security_group_ids              = [aws_security_group.rds.id]
  port                                = 3306
  iam_database_authentication_enabled = false
  parameter_group_name                = aws_db_parameter_group.this.name
  option_group_name                   = aws_db_option_group.this.name
  backup_retention_period             = 7
  backup_window                       = "19:00-20:00"
  copy_tags_to_snapshot               = true
  storage_encrypted                   = true
  monitoring_interval                 = 60
  monitoring_role_arn                 = var.rds_role_arn
  enabled_cloudwatch_logs_exports     = ["error", "general", "slowquery"]
  auto_minor_version_upgrade          = false
  maintenance_window                  = "Sat:20:00-Sat:21:00"
  deletion_protection                 = false
  skip_final_snapshot                 = true
  apply_immediately                   = false

  lifecycle {
    ignore_changes = [password]
  }
}
