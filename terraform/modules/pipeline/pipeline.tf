################################
# Code Commit
################################
resource "aws_codecommit_repository" "this" {
  repository_name = "sccafold"
  description     = "App repository for sccafold"
}

################################
# ECR
################################
resource "aws_ecr_repository" "this" {
  name                 = "sccafold"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

################################
# Code Build
################################
resource "aws_codebuild_project" "this" {
  name           = "sccafold"
  description    = "App build project for sccafold"
  build_timeout  = 5
  queued_timeout = 5
  service_role   = var.codebuild_role_arn

  source {
    type            = "CODECOMMIT"
    location        = aws_codecommit_repository.this.clone_url_http
    git_clone_depth = 1
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.account_id
    }

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = "ap-northeast-1"
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = aws_ecr_repository.this.name
    }

    environment_variable {
      name  = "IMAGE_TAG"
      value = "latest"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/codebuild/sccafold"
      stream_name = ""
    }
  }
}
