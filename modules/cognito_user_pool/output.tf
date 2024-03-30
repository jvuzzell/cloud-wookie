output "user_pool_id" {
  description = "The ID of the user pool."
  value       = aws_cognito_user_pool.main.id
}

output "user_pool_arn" {
  description = "The ARN of the user pool."
  value       = aws_cognito_user_pool.main.arn
}

output "client_id" {
  description = "The client ID of the Cognito User Pool app client."
  value       = aws_cognito_user_pool_client.my_client.id # Adjust based on your resource name
}
