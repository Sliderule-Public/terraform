resource "aws_s3_bucket" "bucket" {
  bucket = "${var.company_name}-${var.environment}-${var.bucket_name}"
  acl    = "private"
  versioning {
    enabled = var.versioning
  }
  policy = var.policy

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  dynamic cors_rule {
    for_each = var.upload_cors_rules_enabled == true ? [1]:[]
    content {
      allowed_headers = [
        "*",
      ]
      allowed_methods = [
        "GET",
        "PUT",
        "POST",
      ]
      allowed_origins = [
        "*",
      ]
      expose_headers  = []
      max_age_seconds = 0
    }
  }


  tags = var.tags
}
resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = var.block_public_access
  block_public_policy     = var.block_public_access
  ignore_public_acls      = var.block_public_access
  restrict_public_buckets = var.block_public_access
}
