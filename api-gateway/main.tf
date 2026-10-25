# Modern HTTP API (API Gateway v2)
resource "aws_apigatewayv2_api" "http_api" {
  name          = "${var.project_name}-api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["POST", "OPTIONS"]
    allow_headers = ["Content-Type", "Authorization"]
    max_age       = 300
  }

  tags = {
    Project = var.project_name
  }
}

# Auto-deploying $default stage (Enterprise best practice for serverless APIs)
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}

# Connects API Gateway to Lambda via AWS Proxy Integration
resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.lambda_invoke_arn
  payload_format_version = "2.0"
}

# Defines the POST /leads route
resource "aws_apigatewayv2_route" "post_leads" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "POST /leads"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}