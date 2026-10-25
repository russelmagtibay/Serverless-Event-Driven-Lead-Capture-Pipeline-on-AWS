resource "aws_dynamodb_table" "leads" {
  name         = "${var.project_name}-leads"
  billing_mode = "PAY_PER_REQUEST"

  hash_key  = "email"
  range_key = "timestamp"

  attribute {
    name = "email"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }

  tags = {
    Name    = "${var.project_name}-leads-table"
    Project = var.project_name
  }
}
