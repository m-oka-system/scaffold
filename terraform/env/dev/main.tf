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
      env = "dev"
    }
  }
}

provider "http" {}

module "dev" {
  source = "../.."

  region         = var.region
  project        = var.project
  env            = var.env
  vpc_cidr       = var.vpc_cidr
  public_key     = var.public_key
  vpc_id         = module.dev.vpc_id
  ecr_repository = module.pipeline.ecr_repository
  ecs_role_arn   = module.iam.ecs_role_arn
}

module "iam" {
  source = "../../modules/iam"
}

module "pipeline" {
  source = "../../modules/pipeline"

  region             = var.region
  project            = var.project
  env                = var.env
  account_id         = data.aws_caller_identity.current.account_id
  codebuild_role_arn = module.iam.codebuild_role_arn
}

module "dev_app" {
  source = "../../modules/ec2"

  project          = var.project
  env              = var.env
  subnet_id        = module.dev.public_subnet_id_0
  sg_id            = module.dev.app_sg_id
  instance_profile = module.iam.instance_profile_name
  key_name         = module.dev.key_name
  role             = "app"
  instance_type    = "t2.micro"
}

output "public_ip_app" {
  value = module.dev_app.public_ip
}
