variable "vpc_id" {
  description = "The ID of the VPC for the route table"
}

variable "route_table_name" {
  description = "Name of the route table"
}

variable "common_tags" {
  description = "Common tags for all resources in the module"
  type        = map(string)
}

variable "routes" {
  description = "A map of routes in the route table"
  type        = map(object({
    destination_cidr_block = string
    gateway_id             = string
    nat_gateway_id         = string
  }))
}

variable "subnet_ids" {
  description = "List of subnet IDs to associate with the route table"
  type        = list(string)
}
