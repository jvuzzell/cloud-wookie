output "identity_pool_id" {
  description = "The ID of the identity pool."
  value       = aws_cognito_identity_pool.main.id
}