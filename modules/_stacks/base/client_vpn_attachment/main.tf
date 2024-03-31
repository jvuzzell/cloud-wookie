module "client_vpn" { 
  source = "../../../client_vpn"

  vpc_id                                    = var.vpc_id
  vpc_cidr_block                            = var.vpc_cidr_block  
  client_vpn_cidr_block                     = var.client_vpn_cidr_block
  client_vpn_endpoint_name                  = var.client_vpn_endpoint_name 
  client_vpn_security_group_name            = var.client_vpn_security_group_name
  client_vpn_network_association_subnet_ids = var.client_vpn_network_association_subnet_ids
  server_certificate_arn                    = var.server_certificate_arn
  common_tags                               = var.common_tags
}