resource "aws_cognito_user_pool" "main" {
  name = var.pool_name

  password_policy {
    minimum_length    = var.password_minimum_length
    require_lowercase = var.password_require_lowercase
    require_numbers   = var.password_require_numbers
    require_symbols   = var.password_require_symbols
    require_uppercase = var.password_require_uppercase
  }

  auto_verified_attributes = var.user_pool_auto_verify_attr
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = var.user_pool_app_client_name
  user_pool_id = aws_cognito_user_pool.main.id
  
  // Additional configurations...
}
