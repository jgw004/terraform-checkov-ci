# Security-first example. Static analysis requires NO AWS account.

resource "aws_s3_bucket" "portfolio" {
  bucket_prefix = "portfolio-checkov-lab-"

  tags = {
    Project	= "terraform-checkov-ci"
    Environment = "personal-lab"
  }
}

resource "aws_s3_bucket_public_access_block" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id
 
  # Checkov: CKV_AWS_53 through CKV_AWS_56
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id
  versioning_configuration {
    status = "Enabled"
  }
}


