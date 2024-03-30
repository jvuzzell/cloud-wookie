output "identity_pool_id" {
  description = "The ID of the identity pool."
  value       = aws_cognito_identity_pool.main.id
}

output "authenticated_role_arn" {
  description = "The ARN of the IAM role for authenticated users."
  value       = aws_iam_role.authenticated_role.arn
}
