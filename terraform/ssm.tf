################################
# SSM
################################
resource "aws_ssm_parameter" "ecs_db_user" {
  name  = "/${var.env}/${var.project}/ecs-db-user"
  type  = "SecureString"
  value = var.db_user_name
}

resource "aws_ssm_parameter" "ecs_db_password" {
  name  = "/${var.env}/${var.project}/ecs-db-password"
  type  = "SecureString"
  value = var.db_user_password

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "ecs_db_host_name" {
  name  = "/${var.env}/${var.project}/ecs-db-host-name"
  type  = "SecureString"
  value = aws_db_instance.this.address
}

resource "aws_ssm_parameter" "rails_master_key" {
  name  = "/${var.env}/${var.project}/rails-master-key"
  type  = "SecureString"
  value = var.rails_master_key

  lifecycle {
    ignore_changes = [value]
  }
}
