resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.default_route
    gateway_id = var.internet_gateway_id
  }

  tags = merge(
    var.tags,
    {
      Name = "route_table" # This is a default tag value
    }
  )
}

resource "aws_route_table_association" "association" {
  for_each       = var.subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.route_table.id
}