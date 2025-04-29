variable "private_ec2_name" {}
variable "private_ec2_ami" {}
variable "private_ec2_type" {}
variable "private_key_pair" {}
variable "private_ec2_subnet_ids" {}
variable "private_sg" {}
variable "private_associate_public_ip_address" {}


resource "aws_key_pair" "proj_private_ec2_key_pair" {
  key_name = "Private_Key_Pair"
  public_key = var.private_key_pair
}


#Out put for EC2 Private ID
output "ec2_private_id" {
  value = aws_instance.proj_ec2_instnace.*.id
}

resource "aws_instance" "proj_ec2_instnace" {
    count = length(var.private_ec2_ami)
    ami = element(var.private_ec2_ami, count.index)
    instance_type = var.private_ec2_type
    key_name = aws_key_pair.proj_private_ec2_key_pair.key_name
    subnet_id = var.private_ec2_subnet_ids[count.index]
    vpc_security_group_ids = [var.private_sg]
    associate_public_ip_address = var.private_associate_public_ip_address

  tags = {
    Name = var.private_ec2_name

  }
}