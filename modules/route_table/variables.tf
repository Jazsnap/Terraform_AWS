variable "vpc_id" {
  description = "The VPC id of the default VPC"
}

variable "cidr_block" {
  description = "The CIDR block to use for the VPN"
}

variable "internet_gateway_id" {
  description = "The id of the internet gateway for the default vpn"
}

variable "tags" {
  description = "A map of tags to add to the resource"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Module    = "route_table"
  }
}