variable "bucket_name" {
  type        = string
  description = "S3 bucket name prefix (must be lowercase)"
  default     = "static-website"
}

variable "project_name" {
  type        = string
  description = "Project name tag"
  default     = "serverless-lead-capture"
}

variable "enable_direct_public_access" {
  type        = bool
  description = "Set to true to allow direct public website access (lab testing), or false when using CloudFront"
  default     = true
}
