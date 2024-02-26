variable "vpc_cidr_block" {}
variable "vpc_enable_dns_support" {}
variable "vpc_enable_dns_hostnames" {}
variable "vpc_name" {}
variable "vpc_id" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "nacl_name" {}
variable "igw_name" {}
variable "ingress_rules" {}
variable "egress_rules" {}
variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {}
}
