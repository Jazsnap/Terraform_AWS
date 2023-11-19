resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true  # default is true
  enable_dns_hostnames = false # default is false
}

resource "aws_subnet" "subnets" {
  vpc_id     = aws_vpc.vpc.id
  for_each   = toset(var.subnets)
  cidr_block = each.value
  // ... other configurations ...
}
