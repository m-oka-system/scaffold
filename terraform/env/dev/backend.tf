terraform {
  backend "s3" {
    bucket  = "cloud03-tf-remote-state-bucket"
    key     = "ap-northeast-1/dev/main.tfstate"
    region  = "ap-northeast-1"
    profile = "cloud02"
  }
}
