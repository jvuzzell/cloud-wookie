variable "common_tags" {
  description = "A map of tags that will be applied to all resources created by the Terraform configuration. These often include metadata like environment, project name, and cost center."
  type        = map(string)
  default     = {}
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC. This defines the IP address range of the VPC."
  type        = string
}

variable "vpc_enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC. Enables instances in the VPC to resolve DNS hostnames into IP addresses."
  type        = bool
}

variable "vpc_enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC. Allows instances in the VPC to receive a DNS hostname."
  type        = bool
}

variable "vpc_name" {
  description = "The name of the VPC. This will be used to tag resources with a name for easier identification."
  type        = string
}

variable "vpc_id" {
  description = "The ID of an existing VPC where resources will be deployed. This is used when integrating with an existing VPC."
  type        = string
}

variable "public_subnets" {
  description = "A list of public subnet IDs for the VPC. These subnets have routes to the Internet Gateway."
}

variable "private_subnets" {
  description = "A list of private subnet IDs for the VPC. These subnets do not have direct access to the internet."
}

variable "nacl_name" {
  description = "The name of the Network Access Control List (NACL) to be created or used. NACLs provide a layer of security at the subnet level."
  type        = string
}

variable "igw_name" {
  description = "The name of the Internet Gateway (IGW) to be created or used. The IGW allows communication between the VPC and the internet."
  type        = string
}

variable "ingress_rules" {
  description = "A list of ingress rules to apply to a security group or network ACL. Defines what inbound traffic is permitted."
  type        = any
}

variable "egress_rules" {
  description = "A list of egress rules to apply to a security group or network ACL. Defines what outbound traffic is permitted."
  type        = any
}

variable "client_vpn_endpoint_name" {
  description = "The name of the Client VPN endpoint. This endpoint allows secure connections to the VPC from a client."
  type        = string
}

variable "client_vpn_security_group_name" {
  description = "The name of the security group associated with the Client VPN endpoint. Defines the rules for traffic to and from the clients connected through the VPN."
  type        = string
}

variable "client_vpn_cidr_block" {
  description = "The CIDR block to be used by the Client VPN endpoint. Specifies the IP range from which client IP addresses are assigned."
  type        = string
}

variable "domain_name" {
  description = "The domain name for the ACM certificate. Used for SSL/TLS on a custom domain."
  type        = string
}

variable "client_vpn_zone_id" {
  description = "The Route 53 zone ID to use for DNS validation of the ACM certificate for the Client VPN endpoint."
  type        = string
}

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
  type        = string
}