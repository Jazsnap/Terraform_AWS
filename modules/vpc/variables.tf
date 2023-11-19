variable "cidr_block" {
  description = "The CIDR block to use for the VPN"
}

variable "subnets" {
  description = "A list of subnet CIDR blocks"
  type        = list(string)
}
