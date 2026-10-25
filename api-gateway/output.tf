output "api_endpoint" {
  value       = aws_apigatewayv2_api.http_api.api_endpoint
  description = "The base HTTP API endpoint"
}

output "execution_arn" {
  value       = aws_apigatewayv2_api.http_api.execution_arn
  description = "The execution ARN of the API Gateway"
}

output "leads_url" {
  value       = "${aws_apigatewayv2_api.http_api.api_endpoint}/leads"
  description = "Direct POST URL for capturing leads"
}