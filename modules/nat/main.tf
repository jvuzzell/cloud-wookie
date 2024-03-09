resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = merge(
    var.common_tags,
    {
      "Name" = "nat-eip-${var.availability_zone}"
    }
  )
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.subnet_id

  tags = merge(
    var.common_tags,
    {
      "Name" = "nat-gw-${var.availability_zone}"
    }
  )
}
