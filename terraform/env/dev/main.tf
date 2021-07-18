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

module "dev" {
  source = "../.."

  prefix     = var.prefix
  vpc_cidr   = var.vpc_cidr
  public_key = var.public_key
}

module "dev_iam" {
  source = "../../modules/iam"
}
