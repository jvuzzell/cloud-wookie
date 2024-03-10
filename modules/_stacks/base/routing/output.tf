output "nacl_id" {
  value = module.my_nacl.nacl_id
  description = "The ID of the Network Access Control List (NACL) created."
}

output "nat_gateway_ids" {
  value = {
    az1 = module.nat_gw_az1.nat_gw_id
    az2 = module.nat_gw_az2.nat_gw_id
  }
  description = "The IDs of the NAT Gateways created in each availability zone."
}

output "public_route_table_id" {
  value = module.public_route_table.route_table_id
  description = "The ID of the public route table created."
}

output "private_route_table_ids" {
  value = {
    az1 = module.private_route_table_az1.route_table_id
    az2 = module.private_route_table_az2.route_table_id
  }
  description = "The IDs of the private route tables created for each availability zone."
}
