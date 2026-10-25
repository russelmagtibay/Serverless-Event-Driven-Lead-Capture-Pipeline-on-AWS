output "bucket_id" {
  value       = aws_s3_bucket.bucket.id
  description = "The name/ID of the S3 bucket"
}

output "bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "The ARN of the S3 bucket"
}

output "bucket_regional_domain_name" {
  value       = aws_s3_bucket.bucket.bucket_regional_domain_name
  description = "Regional domain name of the S3 bucket (for CloudFront origin)"
}

output "website_endpoint" {
  value       = aws_s3_bucket_website_configuration.static_website.website_endpoint
  description = "The S3 website endpoint"
}
