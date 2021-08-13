data "aws_ecr_repository" "this" {
  name = var.project
}

data "aws_iam_instance_profile" "ec2" {
  name = "ec2-admin-role"
}

data "aws_iam_role" "ecs" {
  name = "ecs-task-execution-role"
}

data "aws_iam_role" "rds" {
  name = "rds-enhanced-monitoring-role"
}

data "aws_route53_zone" "this" {
  name = var.my_domain
}

data "aws_acm_certificate" "this" {
  domain = var.my_domain
}

data "aws_s3_bucket" "this" {
  bucket = "${var.project}-elb-logs"
}
