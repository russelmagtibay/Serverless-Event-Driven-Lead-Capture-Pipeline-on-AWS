resource "aws_ses_email_identity" "business_owner" {
  email = var.notification_email
}
