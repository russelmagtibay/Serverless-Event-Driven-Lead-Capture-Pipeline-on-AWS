variable "project_name" {
  type        = string
  description = "Project name tag"
  default     = "serverless-lead-capture"
}

variable "dynamodb_table_name" {
  type        = string
  description = "Target DynamoDB table name"
}

variable "dynamodb_table_arn" {
  type        = string
  description = "Target DynamoDB table ARN for IAM policy"
}

variable "notification_email" {
  type        = string
  description = "Verified email address to send notifications"
}
