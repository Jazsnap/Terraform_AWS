resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  enable_dns_support = true # default is true
  enable_dns_hostnames = false # default is false
}

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_1_cidr_block
}

resource "aws_subnet" "subnet_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_2_cidr_block
}

# Additional resources like Internet Gateway, Route Tables, etc.
