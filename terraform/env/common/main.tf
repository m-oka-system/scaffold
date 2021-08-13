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
      env = "common"
    }
  }
}

provider "http" {}

module "elb_log" {
  source = "./modules/s3_logs"

  env                 = var.env
  bucket_name         = "${var.project}-elb-logs"
  policy_file         = "elb_log.json"
  elb_service_account = data.aws_elb_service_account.main.arn
}

module "iam" {
  source = "./modules/iam"
}

module "pipeline" {
  source = "./modules/pipeline"

  region             = var.region
  project            = var.project
  env                = var.env
  account_id         = data.aws_caller_identity.current.account_id
  codebuild_role_arn = module.iam.codebuild_role_arn
}

module "dns" {
  source = "./modules/dns"

  my_domain = var.my_domain
}
