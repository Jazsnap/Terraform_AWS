resource "aws_security_group" "dynamic_sg" {
  name        = "dynamic-sg"
  description = "Security group with dynamic ingress rules"
  vpc_id      = var.vpc_id

  // Static SSH ingress rule
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["62.167.161.52/32"]
    description = "SSH"
  }

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }
  // Define any egress rules or other configurations as needed
}
