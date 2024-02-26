variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "common_tags" {
  description = "Common tags for all resources in the module"
  type        = map(string)
}

variable "igw_name" {}