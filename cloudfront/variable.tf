variable "project_name" {
  type        = string
  description = "Project name tag"
  default     = "serverless-lead-capture"
}

variable "s3_bucket_regional_domain_name" {
  type        = string
  description = "Regional domain name of the S3 bucket"
}