output "bucket_name" {
  value       = module.s3_static_website.bucket_id
  description = "The S3 bucket name"
}

output "website_endpoint" {
  value       = "http://${module.s3_static_website.website_endpoint}"
  description = "The direct S3 website URL"
}

output "cloudfront_url" {
  value       = "https://${module.cloudfront.distribution_domain_name}"
  description = "Your live HTTPS website URL"
}

output "dynamodb_table_name" {
  value       = module.dynamodb.table_name
  description = "The name of the DynamoDB table for leads"
}

output "website_url" {
  value       = "https://${module.cloudfront.distribution_domain_name}"
  description = "Your live eBook website URL"
}

output "api_leads_url" {
  value       = module.api_gateway.leads_url
  description = "The endpoint URL where your form sends POST requests"
}

output "dynamodb_table" {
  value       = module.dynamodb.table_name
  description = "DynamoDB table storing leads"
}

output "verified_email" {
  value       = module.ses.verified_email
  description = "SES notification recipient"
}