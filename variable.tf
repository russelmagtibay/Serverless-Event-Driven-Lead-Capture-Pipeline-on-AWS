variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources into"
  default     = "ap-southeast-1"
}

variable "project_name" {
  type        = string
  description = "Project name tag"
  default     = "serverless-lead-capture"
}



variable "notification_email" {
  type        = string
  description = "Email address for SES lead notifications"
  default     = "russelmagtibay15@gmail.com" # Put your real email here!
}