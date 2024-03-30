provider "aws" {
    region = "us-east-2"
}
module "network" {
    source = "./modules/network"
    
    vpc_id                         = var.vpc_id
    common_tags                    = var.common_tags
    vpc_cidr_block                 = var.vpc_cidr_block
    vpc_enable_dns_support         = var.vpc_enable_dns_support
    vpc_enable_dns_hostnames       = var.vpc_enable_dns_hostnames
    vpc_name                       = var.vpc_name
    public_subnets                 = var.public_subnets
    private_subnets                = var.private_subnets
    igw_name                       = var.igw_name
    nacl_name                      = var.nacl_name
    ingress_rules                  = var.ingress_rules
    egress_rules                   = var.egress_rules
    client_vpn_cidr_block          = var.client_vpn_cidr_block
    client_vpn_endpoint_name       = var.client_vpn_endpoint_name
    client_vpn_security_group_name = var.client_vpn_security_group_name
    client_vpn_zone_id             = var.client_vpn_zone_id
    domain_name                    = var.domain_name
}

module "identity-management" {
  source = "./modules/identity-management"
}