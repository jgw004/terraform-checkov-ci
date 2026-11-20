output "sandbox_bucket_name" {
  description = "The S3 bucket name after an OPTIONAL terraform apply"
  value       = aws_s3_bucket.portfolio.id
}

