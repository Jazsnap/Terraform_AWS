resource "aws_instance" "ec2_vm" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  tags = merge(
    var.tags,
    {
      Name = "ec2_vm" # This is a default tag value
    }
  )
}
