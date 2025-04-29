variable "key_pair" {}
variable "ami_id" {}
variable "ec2_type" {}
variable "subnet_ids" {}
variable "sg_ids" {}
variable "enable_public_id" {}
variable "ec2_name" {}


# This is output for EC2 Public ID
output "ec2_public_id" {
  value = aws_instance.proj_ec2_instnace.*.id
}

# This is Key_Pair for aws_instance
resource "aws_key_pair" "proj_ec2_key_pair" {
  key_name = "Key_Pair"
  public_key = var.key_pair
}

# Public Ec2 Instance
resource "aws_instance" "proj_ec2_instnace" {
  count = length(var.ami_id)
  ami = element(var.ami_id, count.index)
  instance_type = var.ec2_type
  key_name = aws_key_pair.proj_ec2_key_pair.key_name
  subnet_id = var.subnet_ids[count.index]
  vpc_security_group_ids = [var.sg_ids]
  associate_public_ip_address = var.enable_public_id

  tags = {
    Name = var.ec2_name
  }
}


