locals {
  common_tags = {
    Environment = "dev"
    Project     = "Jason"
  }
  subnet_prefixes = ["10.0.1", "10.0.2", "10.0.3"]
  number_of_subnets = 3
}
