provider "aws" {
    region = "us-east-2"
}

module "acm_certificate" {
  source      = "../../../../../../modules/acm_certificate"
  
  domain_name = var.domain_name
  zone_id     = var.client_vpn_zone_id
}
