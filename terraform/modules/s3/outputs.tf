output "bucket_name" {
  description = "S3 bucket name."
  value       = aws_s3_bucket.reports.bucket
}

output "bucket_arn" {
  description = "S3 bucket ARN."
  value       = aws_s3_bucket.reports.arn
}

output "bucket_domain_name" {
  description = "S3 bucket regional domain name."
  value       = aws_s3_bucket.reports.bucket_regional_domain_name
}