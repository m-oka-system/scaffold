data "aws_caller_identity" "current" {}

data "terraform_remote_state" "common" {
  backend = "s3"

  config = {
    bucket  = "cloud03-tf-remote-state-bucket"
    key     = "ap-northeast-1/common/main.tfstate"
    region  = "ap-northeast-1"
    profile = "cloud02"
  }
}
