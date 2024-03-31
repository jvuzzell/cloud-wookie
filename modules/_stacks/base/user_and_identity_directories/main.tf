module "cognito_user_pool" {
  source = "../../../cognito_user_pool"

  pool_name                  = var.user_pool_name
  password_minimum_length    = 8
  password_require_lowercase = true
  password_require_numbers   = true
  password_require_symbols   = true
  password_require_uppercase = true
  user_pool_auto_verify_attr = var.user_pool_auto_verify_attr

  user_pool_app_client_name  = var.user_pool_app_client_name
}

module "cognito_identity_pool" {
  source = "../../../cognito_identity_pool"

  identity_pool_name      = var.identity_pool_name
  user_pool_client_id     = module.cognito_user_pool.client_id
  user_pool_id            = module.cognito_user_pool.user_pool_id
  aws_region              = var.identity_pool_region
}
