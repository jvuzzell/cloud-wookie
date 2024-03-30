variable "pool_name" {
  description = "The name of the user pool."
  type        = string
}

variable "password_minimum_length" {
  description = "The minimum length of the password policy."
  type        = number
  default     = 8
}

variable "password_require_lowercase" {
  description = "Whether the password policy requires lowercase."
  type        = bool
  default     = true
}

variable "password_require_numbers" {
  description = "Whether the password policy requires numbers."
  type        = bool
  default     = true
}

variable "password_require_symbols" {
  description = "Whether the password policy requires symbols."
  type        = bool
  default     = true
}

variable "password_require_uppercase" {
  description = "Whether the password policy requires uppercase."
  type        = bool
  default     = true
}

variable "auto_verified_attributes" {
  description = "The attributes to be auto-verified. Possible values: email, phone_number."
  type        = list(string)
  default     = ["email"]
}
