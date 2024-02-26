variable "subnet_id" {
  description = "The ID of the subnet in which to place the NAT Gateway"
}

variable "availability_zone" {
  description = "The Availability Zone where the NAT Gateway is created"
}

variable "common_tags" {
  description = "Common tags for all resources in the module"
  type        = map(string)
}
