resource "aws_key_pair" "key_pair" {
  key_name   = "default-key"
  public_key = var.public_key
}