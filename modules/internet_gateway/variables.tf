variable "vpc_id" {
  description = "The VPC id of the default VPC"
}

variable "tags" {
  description = "A map of tags to add to the resource"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Module    = "igw"
  }
}