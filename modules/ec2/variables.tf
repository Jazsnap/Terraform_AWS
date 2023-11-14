variable "ami" {
  description = "The AMI to use for the instance"
}

variable "instance_type" {
  description = "The type of instance to start"
}

variable "subnet_id" {
  description = "The subnet id of the default vpn"
}

variable "public_ip" {
  description = "Whether to assign a public IP to the instance"
}

variable "tags" {
  description = "A map of tags to add to the resource"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Module    = "ec2"
  }
}
