variable "common_tags" {}
variable "client_vpn_endpoint_name" {}
variable "client_vpn_cidr_block" {}
variable "server_certificate_arn" {}
variable "vpc_cidr_block" {} 
variable "vpc_id" {}
variable "client_vpn_security_group_name" {}
variable "client_vpn_network_association_subnet_ids" {
  type = list(string)
}

variable "domain_name" {
  description = "The domain name for the ACM certificate."
  type        = string
}

variable "client_vpn_zone_id" {
  description = "The Route 53 zone ID to use for DNS validation."
  type        = string
}