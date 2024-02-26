variable "vpc_id" {
  description = "The VPC ID where the subnet will be created"
}

variable "cidr_block" {
  description = "The CIDR block for the subnet"
}

variable "availability_zone" {
  description = "The availability zone where the subnet will be created"
}

variable "map_public_ip_on_launch" {
  description = "Boolean to enable/disable public IP on launch"
  default     = false
}

variable "common_tags" {
  description = "Common tags for all resources in the module"
  type        = map(string)
}

variable "subnet_name" {}