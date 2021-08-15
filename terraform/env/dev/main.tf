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
  ecr_repository      = data.terraform_remote_state.common.outputs.ecr_repository
  ecs_role_arn        = data.terraform_remote_state.common.outputs.ecs_role_arn
  db_user_name        = var.db_user_name
  db_user_password    = var.db_user_password
  db_instance_class   = var.db_instance_class
  rds_role_arn        = data.terraform_remote_state.common.outputs.rds_role_arn
  my_domain           = var.my_domain
  hosted_zone_id      = data.terraform_remote_state.common.outputs.hosted_zone_id
  acm_certificate_arn = data.terraform_remote_state.common.outputs.acm_certificate_arn
  rails_master_key    = var.rails_master_key
  elb_bucket_name     = data.terraform_remote_state.common.outputs.elb_bucket_name
}

module "dev_app" {
  source = "../../modules/ec2"

  project          = var.project
  env              = var.env
  subnet_id        = module.dev.public_subnet_id_0
  sg_id            = module.dev.web_sg_id
  instance_profile = data.terraform_remote_state.common.outputs.instance_profile_name
  key_name         = module.dev.key_name
  role             = "app"
  instance_type    = "t2.micro"
}

output "public_ip_app" {
  value = module.dev_app.public_ip
}
