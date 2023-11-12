provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"

  cidr_block          = "10.0.0.0/16"
  subnet_1_cidr_block = "10.0.1.0/24"
  subnet_2_cidr_block = "10.0.2.0/24"
}

module "ec2_instance_1" {
  source = "./modules/ec2"

  ami           = "ami-05c13eab67c5d8861" # Amazon Linux 2023 AMI 2023.2.20231030.1 x86_64 HVM kernel-6.1 us-east-1
  instance_type = "t2.micro"              # Free tier
  subnet_id     = module.vpc.subnet_1_id
}

module "ec2_instance_2" {
  source = "./modules/ec2"

  ami           = "ami-05c13eab67c5d8861" # Amazon Linux 2023 AMI 2023.2.20231030.1 x86_64 HVM kernel-6.1 us-east-1
  instance_type = "t2.micro"              # Free tier
  subnet_id     = module.vpc.subnet_2_id
}
