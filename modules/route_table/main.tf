resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      "Name" = "rt-${var.route_table_name}"
    }
  )
}

resource "aws_route" "route" {
  for_each           = var.routes
  route_table_id     = aws_route_table.route_table.id
  destination_cidr_block = each.value.destination_cidr_block
  gateway_id         = each.value.gateway_id
  nat_gateway_id     = each.value.nat_gateway_id
}

resource "aws_route_table_association" "subnet_association" {
  for_each       = toset(var.subnet_ids)
  subnet_id      = each.value
  route_table_id = aws_route_table.route_table.id
}
