
################################
# S3
################################
resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id      = "expired-30-days"
    enabled = true

    expiration {
      days = "30"
    }

    noncurrent_version_expiration {
      days = "30"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = templatefile(
    "../../modules/s3_logs/bucket_policies/${var.policy_file}",
    {
      env                 = var.env
      bucket_name         = var.bucket_name
      elb_service_account = var.elb_service_account
    }
  )

  depends_on = [aws_s3_bucket_public_access_block.this]
}
