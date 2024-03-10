module "my_vpc" {
    source = "../../../vpc"

    cidr_block           = var.vpc_cidr_block
    enable_dns_support   = var.vpc_enable_dns_support
    enable_dns_hostnames = var.vpc_enable_dns_hostnames
    vpc_name             = var.vpc_name
    common_tags          = var.common_tags
}

module "public_subnet_1" {
    source = "../../../subnet"

    vpc_id              = module.my_vpc.vpc_id
    cidr_block          = var.public_subnets[0].cidr_block
    availability_zone   = var.public_subnets[0].availability_zone
    map_public_ip_on_launch = var.public_subnets[0].map_public_ip_on_launch 
    subnet_name             = var.public_subnets[0].subnet_name
    common_tags             = var.common_tags
}

module "public_subnet_2" {
    source = "../../../subnet"

    vpc_id              = module.my_vpc.vpc_id
    cidr_block          = var.public_subnets[1].cidr_block
    availability_zone   = var.public_subnets[1].availability_zone
    map_public_ip_on_launch = var.public_subnets[1].map_public_ip_on_launch
    subnet_name             = var.public_subnets[1].subnet_name
    common_tags             = var.common_tags
}

module "private_subnet_1" {
    source = "../../../subnet"

    vpc_id              = module.my_vpc.vpc_id
    cidr_block          = var.private_subnets[0].cidr_block
    availability_zone   = var.private_subnets[0].availability_zone
    map_public_ip_on_launch = var.private_subnets[0].map_public_ip_on_launch
    subnet_name             = var.private_subnets[0].subnet_name
    common_tags             = var.common_tags
}

module "private_subnet_2" {
    source = "../../../subnet"

    vpc_id              = module.my_vpc.vpc_id
    cidr_block          = var.private_subnets[1].cidr_block
    availability_zone   = var.private_subnets[1].availability_zone
    map_public_ip_on_launch = var.private_subnets[1].map_public_ip_on_launch
    subnet_name             = var.private_subnets[1].subnet_name
    common_tags             = var.common_tags
}

module "igw" {
    source      = "../../../igw"
    vpc_id      = module.my_vpc.vpc_id 
    igw_name    = var.igw_name
    common_tags = var.common_tags
}
