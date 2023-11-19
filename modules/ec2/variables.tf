variable "ami" {
  description = "The AMI to use for the instance"
}

variable "instance_type" {
  description = "The type of instance to start"
}

variable "subnet_id" {
  description = "The subnet id"
}

variable "public_ip" {
  description = "Whether to assign a public IP to the instance"
}

variable "security_groups" {
  description = "List of security groups to assign to the VM"
}

variable "key_name" {
  description = "SSH key name"
}

variable "tags" {
  description = "A map of tags to add to the resource"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Module    = "ec2"
  }
}
