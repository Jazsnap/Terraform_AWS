variable "cidr_block" {
  description = "The CIDR block to use for the VPN"
}

variable "subnets" {
  description = "Map of subnets"
  type = map(object({
    cidr_block = string
  }))
}
