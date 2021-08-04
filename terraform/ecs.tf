################################
# ECS
################################
# Cluster
resource "aws_ecs_cluster" "this" {
  name = "${var.env}-${var.project}-cluster"
}

# Task definition
resource "aws_ecs_task_definition" "app" {
  family = "${var.env}-${var.project}-app"

  execution_role_arn       = var.ecs_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "256"
  memory = "512"


  container_definitions = jsonencode(
    [
      {
        name  = "app"
        image = "${var.ecr_repository}:latest"

        portMappings = [
          {
            protocol : "tcp",
            hostPort : 3000,
            containerPort : 3000
          }
        ]

        command = ["rails", "s", "-p", "3000", "-b", "0.0.0.0"]

        environment = [
          {
            name  = "RAILS_ENV"
            value = "production"
          },
          {
            name  = "RAILS_SERVE_STATIC_FILES"
            value = "1"
          }
        ]

        secrets = [
          {
            name      = "MYSQL_ROOT_USER"
            valueFrom = aws_ssm_parameter.ecs_db_user.name
          },
          {
            name      = "MYSQL_ROOT_PASSWORD"
            valueFrom = aws_ssm_parameter.ecs_db_password.name
          },
          {
            name      = "RDS_HOST_NAME"
            valueFrom = aws_ssm_parameter.ecs_db_host_name.name
          },
          {
            name      = "SECRET_KEY_BASE"
            valueFrom = aws_ssm_parameter.rails_master_key.name
          }
        ]

        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = "/ecs/${var.env}/${var.project}"
            awslogs-region        = var.region
            awslogs-stream-prefix = "ecs"
          }
        }
      }
    ]
  )
}
