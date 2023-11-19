output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_ids" {
  value = { for k, subnet in aws_subnet.subnets : k => { id = subnet.id } }
}
