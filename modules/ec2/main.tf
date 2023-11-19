resource "aws_instance" "ec2_vm" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.public_ip
  security_groups             = [var.security_groups]
  key_name                    = var.key_name

  tags = merge(
    var.tags,
    {
      Name = "ec2_vm" # This is a default tag value
    }
  )
}
