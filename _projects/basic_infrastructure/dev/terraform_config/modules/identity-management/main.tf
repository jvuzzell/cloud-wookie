provider "aws" {
    region = "us-east-2"
}
 
module "directories" {
  source = "../../../../../../modules/_stacks/base/user_and_identity_directories"

  user_pool_name             = var.user_pool_name
  user_pool_auto_verify_attr = var.user_pool_auto_verify_attr
  user_pool_app_client_name  = var.user_pool_app_client_name
  identity_pool_name         = var.identity_pool_name
  identity_pool_region       = var.identity_pool_region
}