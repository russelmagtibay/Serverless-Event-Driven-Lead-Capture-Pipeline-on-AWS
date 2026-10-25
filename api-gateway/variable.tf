variable "project_name" {
  type        = string
  description = "Project name tag"
  default     = "serverless-lead-capture"
}

variable "lambda_invoke_arn" {
  type        = string
  description = "The Lambda function invocation ARN"
}