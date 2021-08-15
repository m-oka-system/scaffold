data "aws_caller_identity" "current" {}
data "aws_elb_service_account" "main" {}

variable "region" {
  default = "ap-northeast-1"
}

variable "profile" {
  default = "cloud02"
}

variable "project" {
  default = "scaffold"
}

variable "env" {
  default = "common"
}

variable "my_domain" {}
