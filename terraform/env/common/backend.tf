terraform {
  backend "s3" {
    bucket  = "cloud03-tf-remote-state-bucket"
    key     = "ap-northeast-1/common/main.tfstate"
    region  = "ap-northeast-1"
    profile = "cloud02"
  }
}
