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

  tags = merge(
    local.common_tags,
    {
      Name = "vm_1"
    }
  )
}

module "ec2_instance_2" {
  source = "./modules/ec2"

  ami           = "ami-05c13eab67c5d8861" # Amazon Linux 2023 AMI 2023.2.20231030.1 x86_64 HVM kernel-6.1 us-east-1
  instance_type = "t2.micro"              # Free tier
  subnet_id     = module.vpc.subnet_2_id

  tags = merge(
    local.common_tags,
    {
      Name = "vm_2"
    }
  )
}

module "igw" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "igw"
    }
  )
}

module "route_table" {
  source              = "./modules/route_table"
  vpc_id              = module.vpc.vpc_id
  cidr_block          = "0.0.0.0/0"
  internet_gateway_id = module.igw.internet_gateway_id

  tags = merge(
    local.common_tags,
    {
      Name = "route_table"
    }
  )
}