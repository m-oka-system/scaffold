terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile

  default_tags {
    tags = {
      env = var.env
    }
  }
}

provider "http" {}

module "dev" {
  source = "../.."

  region              = var.region
  project             = var.project
  env                 = var.env
  vpc_cidr            = var.vpc_cidr
  public_key          = var.public_key
  vpc_id              = module.dev.vpc_id
  ecr_repository      = data.aws_ecr_repository.this.repository_url
  ecs_role_arn        = data.aws_iam_role.ecs.arn
  db_user_name        = var.db_user_name
  db_user_password    = var.db_user_password
  db_instance_class   = var.db_instance_class
  rds_role_arn        = data.aws_iam_role.rds.arn
  my_domain           = var.my_domain
  hosted_zone_id      = data.aws_route53_zone.this.id
  acm_certificate_arn = data.aws_acm_certificate.this.arn
  rails_master_key    = var.rails_master_key
  elb_bucket_name     = data.aws_s3_bucket.this.id
}

module "dev_app" {
  source = "../../modules/ec2"

  project          = var.project
  env              = var.env
  subnet_id        = module.dev.public_subnet_id_0
  sg_id            = module.dev.web_sg_id
  instance_profile = data.aws_iam_instance_profile.ec2.role_name
  key_name         = module.dev.key_name
  role             = "app"
  instance_type    = "t2.micro"
}

output "public_ip_app" {
  value = module.dev_app.public_ip
}
