provider "aws" {
    region = "us-east-2"
}
module "base-network" {
    source = "../../../../../modules/_stacks/base/network"
    
    vpc_id                   = var.vpc_id
    common_tags              = var.common_tags
    vpc_cidr_block           = var.vpc_cidr_block
    vpc_enable_dns_support   = var.vpc_enable_dns_support
    vpc_enable_dns_hostnames = var.vpc_enable_dns_hostnames
    vpc_name                 = var.vpc_name
    public_subnets           = var.public_subnets
    private_subnets          = var.private_subnets
    igw_name                 = var.igw_name
}

module "base-routing" {
    source = "../../../../../modules/_stacks/base/routing"
    
    common_tags              = var.common_tags
    vpc_cidr_block           = var.vpc_cidr_block
    vpc_enable_dns_support   = var.vpc_enable_dns_support
    vpc_enable_dns_hostnames = var.vpc_enable_dns_hostnames
    vpc_name                 = var.vpc_name
    public_subnets           = var.public_subnets
    private_subnets          = var.private_subnets
    igw_name                 = var.igw_name
    nacl_name                = var.nacl_name
    ingress_rules            = var.ingress_rules
    egress_rules             = var.egress_rules

    vpc_id                   = module.base-network.vpc_id
    public_subnet_ids        = module.base-network.public_subnet_ids
    private_subnet_ids       = module.base-network.private_subnet_ids
    igw_id                   = module.base-network.igw_id
}

module "client-vpn-attachment" { 
    source = "../../../../../modules/_stacks/base/client_vpn_attachment"

    vpc_id                                    = module.base-network.vpc_id
    domain_name                               = var.domain_name
    client_vpn_zone_id                        = var.client_vpn_zone_id
    common_tags                               = var.common_tags
    vpc_cidr_block                            = var.vpc_cidr_block
    client_vpn_cidr_block                     = var.client_vpn_cidr_block
    client_vpn_endpoint_name                  = var.client_vpn_endpoint_name 
    client_vpn_security_group_name            = var.client_vpn_security_group_name
    client_vpn_network_association_subnet_ids = module.base-network.private_subnet_ids
}