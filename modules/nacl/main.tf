resource "aws_network_acl" "nacl" {
  vpc_id = var.vpc_id
  tags = merge(
    var.common_tags,
    {
      "Name" = var.nacl_name
    }
  )
}

resource "aws_network_acl_rule" "ingress" {
  count = length(var.ingress_rules)

  network_acl_id = aws_network_acl.nacl.id
  rule_number    = var.ingress_rules[count.index]["rule_number"]
  egress         = false
  protocol       = var.ingress_rules[count.index]["protocol"]
  rule_action    = var.ingress_rules[count.index]["rule_action"]
  cidr_block     = var.ingress_rules[count.index]["cidr_block"]
  from_port      = var.ingress_rules[count.index]["from_port"]
  to_port        = var.ingress_rules[count.index]["to_port"]
}

resource "aws_network_acl_rule" "egress" {
  count = length(var.egress_rules)

  network_acl_id = aws_network_acl.nacl.id
  rule_number    = var.egress_rules[count.index]["rule_number"]
  egress         = true
  protocol       = var.egress_rules[count.index]["protocol"]
  rule_action    = var.egress_rules[count.index]["rule_action"]
  cidr_block     = var.egress_rules[count.index]["cidr_block"]
  from_port      = var.egress_rules[count.index]["from_port"]
  to_port        = var.egress_rules[count.index]["to_port"]
}
