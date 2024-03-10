module "my_nacl" {
    source = "../../../nacl"

    vpc_id        = var.vpc_id
    nacl_name     = var.nacl_name
    ingress_rules = var.ingress_rules
    egress_rules  = var.egress_rules
    common_tags   = var.common_tags
}

module "nat_gw_az1" {
    source            = "../../../nat"
    subnet_id         = var.public_subnet_ids[0]
    availability_zone = var.public_subnets[0].availability_zone
    common_tags       = var.common_tags
}

module "nat_gw_az2" {
    source            = "../../../nat"
    subnet_id         = var.public_subnet_ids[1]
    availability_zone = var.public_subnets[1].availability_zone
    common_tags       = var.common_tags
}

module "public_route_table" {
    source            = "../../../route_table"
    vpc_id            = var.vpc_id
    route_table_name  = "public"
    common_tags       = var.common_tags
    routes            = {
        "internet_access" = {
            destination_cidr_block = "0.0.0.0/0"
            gateway_id             = var.igw_id
            nat_gateway_id         = null
        }
    }
    subnet_ids        = var.public_subnet_ids
}

# Creating a separate route table for each private subnet
module "private_route_table_az1" {
    source            = "../../../route_table"
    vpc_id            = var.vpc_id
    route_table_name  = "private_az1"
    common_tags       = var.common_tags
    routes            = {
        "nat_gateway_access" = {
            destination_cidr_block = "0.0.0.0/0"
            gateway_id             = null
            nat_gateway_id         = module.nat_gw_az1.nat_gw_id
        }
    }
    subnet_ids        = [var.private_subnet_ids[0]]
}

module "private_route_table_az2" {
    source            = "../../../route_table"
    vpc_id            = var.vpc_id
    route_table_name  = "private_az2"
    common_tags       = var.common_tags
    routes            = {
        "nat_gateway_access" = {
            destination_cidr_block = "0.0.0.0/0"
            gateway_id             = null
            nat_gateway_id         = module.nat_gw_az2.nat_gw_id
        }
    }
    subnet_ids        = [var.private_subnet_ids[1]]
}
