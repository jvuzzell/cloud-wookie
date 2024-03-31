resource "aws_cognito_identity_pool" "main" {
  identity_pool_name               = var.identity_pool_name
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id         = var.user_pool_client_id
    provider_name     = "cognito-idp.${var.aws_region}.amazonaws.com/${var.user_pool_id}"
    server_side_token_check = false
  }
}