output "table_name" {
  value       = aws_dynamodb_table.leads.name
  description = "The name of the DynamoDB leads table (passed to Lambda)"
}

output "table_arn" {
  value       = aws_dynamodb_table.leads.arn
  description = "The ARN of the DynamoDB table (passed to Lambda IAM policy)"
}