################################
# Security group
################################
# ELB
resource "aws_security_group" "elb" {
  name   = "${var.env}-${var.project}-elb-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.env}-${var.project}-elb-sg"
  }
}

resource "aws_security_group_rule" "in_http_from_all" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb.id
}

resource "aws_security_group_rule" "in_https_from_all" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb.id
}

resource "aws_security_group_rule" "out_all_from_elb" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb.id
}

# EC2
resource "aws_security_group" "web" {
  name   = "${var.env}-${var.project}-web-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.env}-${var.project}-web-sg"
  }
}

data "http" "ipify" {
  url = "http://api.ipify.org"
}

locals {
  myip         = chomp(data.http.ipify.body)
  allowed_cidr = "${local.myip}/32"
}

resource "aws_security_group_rule" "in_ssh_from_myip" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [local.allowed_cidr]
  security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "in_rails_from_myip" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = [local.allowed_cidr]
  security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "out_all_from_web" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
}

# ECS
resource "aws_security_group" "app" {
  name   = "${var.env}-${var.project}-app-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.env}-${var.project}-app-sg"
  }
}

resource "aws_security_group_rule" "in_rails_from_elb" {
  type                     = "ingress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.elb.id
  security_group_id        = aws_security_group.app.id
}

resource "aws_security_group_rule" "out_all_from_app" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app.id
}

# RDS
resource "aws_security_group" "rds" {
  name   = "${var.env}-${var.project}-rds-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.env}-${var.project}-rds-sg"
  }
}

resource "aws_security_group_rule" "in_mysql_from_web" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web.id
  security_group_id        = aws_security_group.rds.id
}

resource "aws_security_group_rule" "in_mysql_from_app" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app.id
  security_group_id        = aws_security_group.rds.id
}

