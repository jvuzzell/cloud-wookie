provider "aws" {
    region = "us-east-2"
}

module "my_vpc" {
    source = "../../modules/vpc"

    cidr_block           = var.vpc_cidr_block
    enable_dns_support   = var.vpc_enable_dns_support
    enable_dns_hostnames = var.vpc_enable_dns_hostnames
    vpc_name             = var.vpc_name
    common_tags          = var.common_tags
}

module "public_subnet_1" {
    source = "../../modules/subnet"

    vpc_id              = module.my_vpc.vpc_id
    cidr_block          = var.public_subnets[0].cidr_block
    availability_zone   = var.public_subnets[0].availability_zone
    map_public_ip_on_launch = var.public_subnets[0].map_public_ip_on_launch 
    subnet_name             = var.public_subnets[0].subnet_name
    common_tags             = var.common_tags
}

module "public_subnet_2" {
    source = "../../modules/subnet"

    vpc_id              = module.my_vpc.vpc_id
    cidr_block          = var.public_subnets[1].cidr_block
    availability_zone   = var.public_subnets[1].availability_zone
    map_public_ip_on_launch = var.public_subnets[1].map_public_ip_on_launch
    subnet_name             = var.public_subnets[1].subnet_name
    common_tags             = var.common_tags
}

module "private_subnet_1" {
    source = "../../modules/subnet"

    vpc_id              = module.my_vpc.vpc_id
    cidr_block          = var.private_subnets[0].cidr_block
    availability_zone   = var.private_subnets[0].availability_zone
    map_public_ip_on_launch = var.private_subnets[0].map_public_ip_on_launch
    subnet_name             = var.private_subnets[0].subnet_name
    common_tags             = var.common_tags
}

module "private_subnet_2" {
    source = "../../modules/subnet"

    vpc_id              = module.my_vpc.vpc_id
    cidr_block          = var.private_subnets[1].cidr_block
    availability_zone   = var.private_subnets[1].availability_zone
    map_public_ip_on_launch = var.private_subnets[1].map_public_ip_on_launch
    subnet_name             = var.private_subnets[1].subnet_name
    common_tags             = var.common_tags
}

module "my_nacl" {
    source = "../../modules/nacl"

    vpc_id        = module.my_vpc.vpc_id
    nacl_name     = var.nacl_name
    ingress_rules = var.ingress_rules
    egress_rules  = var.egress_rules
    common_tags   = var.common_tags
}

module "igw" {
    source      = "../../modules/igw"
    vpc_id      = module.my_vpc.vpc_id 
    igw_name    = var.igw_name
    common_tags = var.common_tags
}

module "nat_gw_az1" {
    source            = "../../modules/nat"
    subnet_id         = module.public_subnet_1.subnet_id
    availability_zone = var.public_subnets[0].availability_zone
    common_tags       = var.common_tags
}

module "nat_gw_az2" {
    source            = "../../modules/nat"
    subnet_id         = module.public_subnet_2.subnet_id
    availability_zone = var.public_subnets[1].availability_zone
    common_tags       = var.common_tags
}

module "public_route_table" {
    source            = "../../modules/route_table"
    vpc_id            = module.my_vpc.vpc_id
    route_table_name  = "public"
    common_tags       = var.common_tags
    routes            = {
        "internet_access" = {
            destination_cidr_block = "0.0.0.0/0"
            gateway_id             = module.igw.igw_id
            nat_gateway_id         = null
        }
    }
    subnet_ids        = [module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id]
}

module "private_route_table" {
    source            = "../../modules/route_table"
    vpc_id            = module.my_vpc.vpc_id
    route_table_name  = "private"
    common_tags       = var.common_tags
    routes            = {
        "nat_gateway_access_az1" = {
            destination_cidr_block = "0.0.0.0/0"
            gateway_id             = null
            nat_gateway_id         = module.nat_gw_az1.nat_gw_id
        },
        "nat_gateway_access_az2" = {
            destination_cidr_block = "0.0.0.0/0"
            gateway_id             = null
            nat_gateway_id         = module.nat_gw_az2.nat_gw_id
        }
    }
    subnet_ids        = [module.private_subnet_1.subnet_id, module.private_subnet_2.subnet_id]
}