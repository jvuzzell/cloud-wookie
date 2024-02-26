variable "vpc_id" {
  description = "The VPC ID where the NACL will be created"
}

variable "nacl_name" {
  description = "The name of the NACL"
}

variable "ingress_rules" {
  description = "List of maps containing ingress rule configurations"
  type        = list(map(any))
}

variable "egress_rules" {
  description = "List of maps containing egress rule configurations"
  type        = list(map(any))
}

variable "common_tags" {
  description = "Common tags for all resources in the module"
  type        = map(string)
}
