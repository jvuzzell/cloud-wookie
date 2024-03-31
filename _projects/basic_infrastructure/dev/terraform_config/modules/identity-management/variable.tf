variable "user_pool_name" {
  description = "The name of the Cognito User Pool. User Pools are user directories that provide sign-up and sign-in options for app users."
  type        = string
}

variable "user_pool_auto_verify_attr" {
  description = "Attributes that are automatically verified when the user signs up. Common values are 'email' and 'phone_number'."
  type        = list(string)
}

variable "identity_pool_name" {
  description = "The name of the Cognito Identity Pool. Identity Pools enable you to grant your users access to other AWS services."
  type        = string
}

variable "identity_pool_region" {
  description = "The AWS region where the Cognito Identity Pool is or will be created."
  type        = string
}

variable "user_pool_app_client_name" {
  description = ""
  type        = string
}