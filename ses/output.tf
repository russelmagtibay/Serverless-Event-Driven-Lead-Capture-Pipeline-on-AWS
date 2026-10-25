output "verified_email" {
  value       = aws_ses_email_identity.business_owner.email
  description = "The verified SES email address"
}

output "verified_email_arn" {
  value       = aws_ses_email_identity.business_owner.arn
  description = "ARN of the verified email identity"
}