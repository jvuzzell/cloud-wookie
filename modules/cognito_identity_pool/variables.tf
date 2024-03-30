variable "identity_pool_name" {
  description = "The name of the identity pool."
  type        = string
}

variable "user_pool_client_id" {
  description = "The client ID from the Cognito User Pool."
  type        = string
}

variable "aws_region" {
  description = "The AWS region where the Cognito User Pool is deployed."
  type        = string
}

variable "user_pool_id" {
  description = "The ID of the Cognito User Pool."
  type        = string
}