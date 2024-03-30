module "cognito_user_pool" {
  source = "../../../cognito_user_pool"

  pool_name                  = "MyUserPool"
  password_minimum_length    = 8
  password_require_lowercase = true
  password_require_numbers   = true
  password_require_symbols   = true
  password_require_uppercase = true
  auto_verified_attributes   = ["email"]
}

module "cognito_identity_pool" {
  source = "../../../cognito_identity_pool"

  identity_pool_name      = "MyIdentityPool"
  user_pool_client_id     = module.cognito_user_pool.client_id # Adjust if your cognito_user_pool module outputs the client_id
  user_pool_id            = module.cognito_user_pool.user_pool_id # This is the new addition
  aws_region              = "us-east-2"
}
