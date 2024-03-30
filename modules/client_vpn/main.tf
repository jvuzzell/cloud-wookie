resource "aws_security_group" "sg" {
  name   = var.client_vpn_security_group_name
  vpc_id = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Incoming VPN connection"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_ec2_client_vpn_endpoint" "client_vpn" {
  description            = var.client_vpn_endpoint_name
  client_cidr_block      = var.client_vpn_cidr_block
  server_certificate_arn = var.server_certificate_arn
  vpc_id                 = var.vpc_id
  split_tunnel           = true
  dns_servers            = [
    cidrhost(var.vpc_cidr_block, 2)
  ]
  security_group_ids = [
    aws_security_group.sg.id
  ]
  authentication_options {
    type = "certificate-authentication"
    root_certificate_chain_arn = var.server_certificate_arn
  }

  connection_log_options {
    enabled = false
  }

  tags = var.common_tags
}

resource "aws_ec2_client_vpn_network_association" "vpn_subnet_association" {
  for_each = toset(var.client_vpn_network_association_subnet_ids)

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn.id
  subnet_id              = each.value
}

resource "aws_ec2_client_vpn_authorization_rule" "vpn_auth_rule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn.id
  target_network_cidr    = var.vpc_cidr_block
  authorize_all_groups   = true
}
