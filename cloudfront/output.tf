output "distribution_id" {
  value       = aws_cloudfront_distribution.s3_distribution.id
  description = "CloudFront distribution ID"
}

output "distribution_arn" {
  value       = aws_cloudfront_distribution.s3_distribution.arn
  description = "CloudFront distribution ARN (needed for S3 bucket policy)"
}

output "distribution_domain_name" {
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
  description = "CloudFront live HTTPS URL (e.g., d1234.cloudfront.net)"
}