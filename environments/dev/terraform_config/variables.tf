variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

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

variable "client_vpn_endpoint_name" {}
variable "client_vpn_security_group_name" {}
variable "client_vpn_cidr_block" {}

variable "domain_name" {
  description = "The domain name for the ACM certificate."
  type        = string
}

variable "client_vpn_zone_id" {
  description = "The Route 53 zone ID to use for DNS validation."
  type        = string
}
