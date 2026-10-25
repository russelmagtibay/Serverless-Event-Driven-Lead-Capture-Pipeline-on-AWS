locals {
  # Common MIME types so browsers render HTML/CSS/JS/images correctly
  mime_types = {
    "html"  = "text/html"
    "css"   = "text/css"
    "js"    = "application/javascript"
    "json"  = "application/json"
    "png"   = "image/png"
    "jpg"   = "image/jpeg"
    "jpeg"  = "image/jpeg"
    "svg"   = "image/svg+xml"
    "ico"   = "image/x-icon"
    "woff"  = "font/woff"
    "woff2" = "font/woff2"
    "ttf"   = "font/ttf"
  }
}

locals {
  all_files     = fileset("${path.root}/Ebook", "**/*")
  website_files = [for f in local.all_files : f if !startswith(f, ".git")]
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.bucket_name}-${random_id.bucket_suffix.hex}"
  force_destroy = true # Allows terraform destroy to work without manual cleanup

  tags = {
    Name    = "${var.bucket_name}-${random_id.bucket_suffix.hex}"
    Project = var.project_name
  }
}

# Public Access Block: dynamically controlled by enable_direct_public_access
resource "aws_s3_bucket_public_access_block" "access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = var.enable_direct_public_access ? false : true
  block_public_policy     = var.enable_direct_public_access ? false : true
  ignore_public_acls      = var.enable_direct_public_access ? false : true
  restrict_public_buckets = var.enable_direct_public_access ? false : true
}

# Website Configuration
resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Upload all Ebook files to S3 (excluding .git)
resource "aws_s3_object" "ebook_files" {
  for_each = toset(local.website_files)

  bucket = aws_s3_bucket.bucket.id
  key    = each.value
  source = "${path.root}/Ebook/${each.value}"
  etag   = filemd5("${path.root}/Ebook/${each.value}")

  content_type = lookup(
    local.mime_types,
    lower(element(split(".", each.value), length(split(".", each.value)) - 1)),
    "application/octet-stream"
  )
}
