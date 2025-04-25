variable "key_pair" {}
variable "ami_id" {}
variable "ec2_type" {}
variable "subnet_ids" {}
variable "sg_ids" {}
variable "enable_public_id" {}
variable "user_data_script" {}
variable "ec2_name" {}


# This is output for EC2 Public ID
output "ec2_public_id" {
  value = aws_instance.proj_ec2_instnace.id
}

# This is Key_Pair for aws_instance
resource "aws_key_pair" "proj_ec2_key_pair" {
  key_name = "Key_Pair"
  public_key = var.key_pair
}

resource "aws_instance" "proj_ec2_instnace" {
  ami = var.ami_id
  instance_type = var.ec2_type
  key_name = aws_key_pair.proj_ec2_key_pair.key_name
  subnet_id = var.subnet_ids
  vpc_security_group_ids = [var.sg_ids]
  associate_public_ip_address = var.enable_public_id
  user_data = var.user_data_script

  tags = {
    Name = var.ec2_name
  }
}
