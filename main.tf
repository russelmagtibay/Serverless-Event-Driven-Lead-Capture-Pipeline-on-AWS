# 1. S3 Static Website (Storage)
module "s3_static_website" {
  source                      = "./modules/s3-static-website"
  bucket_name                 = "russel-lead-capture"
  project_name                = var.project_name
  enable_direct_public_access = false
}

# 2. CloudFront CDN (Global Delivery & HTTPS)
module "cloudfront" {
  source                         = "./modules/cloudfront"
  project_name                   = var.project_name
  s3_bucket_regional_domain_name = module.s3_static_website.bucket_regional_domain_name
}

# 3. S3 Bucket Policy (OAC link between S3 and CloudFront)
resource "aws_s3_bucket_policy" "cloudfront_oac" {
  bucket     = module.s3_static_website.bucket_id
  depends_on = [module.s3_static_website]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontOAC"
        Effect    = "Allow"
        Principal = { Service = "cloudfront.amazonaws.com" }
        Action    = "s3:GetObject"
        Resource  = "${module.s3_static_website.bucket_arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = module.cloudfront.distribution_arn
          }
        }
      }
    ]
  })
}

# 4. DynamoDB (Database for Leads)
module "dynamodb" {
  source       = "./modules/dynamodb"
  project_name = var.project_name
}

# 5. SES Module (Email Identity)
module "ses" {
  source             = "./modules/ses"
  notification_email = var.notification_email
}

# 6. Lambda Module (Compute & Backend Logic)
module "lambda" {
  source              = "./modules/lambda"
  project_name        = var.project_name
  dynamodb_table_name = module.dynamodb.table_name
  dynamodb_table_arn  = module.dynamodb.table_arn
  notification_email  = var.notification_email
}

# 7. API Gateway Module (HTTP API)
module "api_gateway" {
  source            = "./modules/api-gateway"
  project_name      = var.project_name
  lambda_invoke_arn = module.lambda.invoke_arn
}

# 8. API Gateway Lambda Permission (Allows API Gateway to trigger Lambda)
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.api_gateway.execution_arn}/*/*"
}
