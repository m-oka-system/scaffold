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
  region  = "ap-northeast-1"
  profile = "cloud02"

  default_tags {
    tags = {
      env = "dev"
    }
  }
}

provider "http" {}

module "dev" {
  source = "../.."

  prefix     = var.prefix
  vpc_cidr   = var.vpc_cidr
  public_key = var.public_key
  vpc_id     = module.dev.vpc_id
}

module "dev_iam" {
  source = "../../modules/iam"
}

module "codecommit" {
  source = "../../modules/code"
}

module "dev_app" {
  source = "../../modules/ec2"

  prefix           = var.prefix
  subnet_id        = module.dev.public_subnet_id_0
  sg_id            = module.dev.app_sg_id
  instance_profile = module.dev_iam.instance_profile_name
  key_name         = module.dev.key_name
  role             = "app"
  instance_type    = "t2.micro"
}

output "public_ip_app" {
  value = module.dev_app.public_ip
}
