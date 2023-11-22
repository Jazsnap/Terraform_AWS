provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"

  cidr_block = "10.0.0.0/16"
  subnets = { for idx in range(local.number_of_subnets) :
    "subnet${idx + 1}" => {
      cidr_block = "10.0.${idx + 1}.0/24",
      Name       = "subnet${idx + 1}"
    }
  }
}

module "ec2_instance_1" {
  source = "./modules/ec2"

  ami             = "ami-05c13eab67c5d8861" # Amazon Linux 2023 AMI 2023.2.20231030.1 x86_64 HVM kernel-6.1 us-east-1
  instance_type   = "t2.micro"              # Free tier
  subnet_id       = module.vpc.subnet_ids["subnet1"].id
  public_ip       = true
  security_groups = module.security_group.aws_security_group_id
  key_name        = module.key_pair.key_name

  tags = merge(
    local.common_tags,
    {
      Name = "vm_1"
    }
  )
}

module "ec2_instance_2" {
  source = "./modules/ec2"

  ami             = "ami-05c13eab67c5d8861" # Amazon Linux 2023 AMI 2023.2.20231030.1 x86_64 HVM kernel-6.1 us-east-1
  instance_type   = "t2.micro"              # Free tier
  subnet_id       = module.vpc.subnet_ids["subnet2"].id
  public_ip       = false
  security_groups = module.security_group.aws_security_group_id
  key_name        = module.key_pair.key_name

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
  default_route       = "0.0.0.0/0"
  internet_gateway_id = module.igw.internet_gateway_id
  subnets             = module.vpc.subnet_ids

  tags = merge(
    local.common_tags,
    {
      Name = "route_table"
    }
  )
}

module "security_group" {
  source        = "./modules/security_group"
  vpc_id        = module.vpc.vpc_id
  ingress_rules = local.ingress_rules
  egress_rules  = local.egress_rules
}

module "key_pair" {
  source     = "./modules/key_pair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDI0KRlfgJ7D210O3svEn5wUj0HXp2EK6Sw2TPBvZelcOvs8TQYW0pN79A7u6OI2qYX8IWrmBk46GNjrvKUHYtPRHru38anGwyKCP0L5iYdMDnr2bQ69jE14qf9Aanlr8mhJuYSRHy05pNnrMVkqSOu3aHJU+f9jI2a2UjaxwMMDru99pE+ve9zS9T98U3AZWDKS3HkOg16juk5o7bXMBjjgI0mWxQWpenhO109vsRjB6HrW3+akycHMrfIY+1SP4mB0I//93wKADSwDf6dZk0mHH/dK7bR5moeledxVe0ppbqrmHiJ9IE/qWxXsWWbkLFn5zL5bIMb4bWMG1/d8pg11LzQ0vOsdRMtMbo1dZMXDfDTUEAFVFkW7Qv5W9nA3kJdrVmfkansRaWmLBt3C07iZyrxyRAZDHFjZ//eFpImeG9Yl35hxYglqUHDfx/sAqeajgXyGasumWeHiZrvWZif5AcAtuW5IOalvXrr3bJQgKhnzojHuB9h0Mn7T/NyUfR4s6OZu/3E02URg2OIoCGjEtoNawMh6TVORG2nu8lurOiGeHZ2QOYAtUQETnkeu6z+R+Ha5FvVgbIt1ShViD5U00YrfRIL8XfSV6k+wDKjmfyZ9syHX5Yh+vJ6p5QtY86U1NM7TlcJQnBX7l4sEP1Mk5dt/ovB1Yuyd4i08/EceQ=="
}