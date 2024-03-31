common_tags = {
  Environment = "Dev"
  Project     = "MyProject"
  // ... other common tags ...
}

# New variables for VPC
vpc_cidr_block           = "10.0.0.0/16"
vpc_enable_dns_support   = true
vpc_enable_dns_hostnames = true
vpc_name                 = "MyVPC"

public_subnets = [
  {
    cidr_block        = "10.0.1.0/24",
    availability_zone = "us-west-2a",
    map_public_ip_on_launch = true,
    subnet_name             = "public_subnet_az1" 
  },
  {
    cidr_block        = "10.0.2.0/24",
    availability_zone = "us-west-2b",
    map_public_ip_on_launch = true, 
    subnet_name             = "public_subnet_az2" 
  }
]

private_subnets = [
  {
    cidr_block        = "10.0.3.0/24",
    availability_zone = "us-west-2a", 
    map_public_ip_on_launch = false, 
    subnet_name             = "private_subnet_az1" 
  },
  {
    cidr_block        = "10.0.4.0/24",
    availability_zone = "us-west-2b", 
    map_public_ip_on_launch = false, 
    subnet_name             = "private_subnet_az2" 
  }
]

nacl_name = "my-nacl"

igw_name = "internet-gateway"

ingress_rules = [
  {
    rule_number = 100
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 80
    to_port     = 80
  },
  // Add more rules as needed
]

egress_rules = [
  {
    rule_number = 100
    protocol    = "-1"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 0
    to_port     = 0
  },
  // Add more rules as needed
]

/**
 * Client VPN
 */

client_vpn_endpoint_name       = "MyClientVPN"
client_vpn_security_group_name = "client-vpn-sg"
client_vpn_cidr_block          = "10.0.5.0/22" 
client_vpn_zone_id             = "value" 
domain_name                    = "value"

/**
 * User and Identity Pool
 */

user_pool_name             = "MyUserPool" 
user_pool_auto_verify_attr = ["email"] 
user_pool_app_client_name  = "MyAppClient"

identity_pool_name         = "MyIdentityPool" 
identity_pool_region       = "us-east-2"