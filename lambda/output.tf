output "function_name" {
  value       = aws_lambda_function.lead_processor.function_name
  description = "The Lambda function name"
}

output "function_arn" {
  value       = aws_lambda_function.lead_processor.arn
  description = "The Lambda function ARN"
}

output "invoke_arn" {
  value       = aws_lambda_function.lead_processor.invoke_arn
  description = "The Lambda invocation ARN used by API Gateway"
}