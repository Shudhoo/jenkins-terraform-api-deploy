# This all variables are of Networking [VPC, Subnets, Route Table, Rout Table Associations, Internet Gateway]
variable "vpc_cidr_my" {
    description = "value for vpc CIDR"
}
variable "public_subnet_cidr" {
    description = "value for public subnets"
}
variable "private_subnet_cidr" {
    description = "value for private subntes"
}
variable "azs" {
    description = "value for avability zones"
}


#This variables are for EC2 Instnace
 variable "ami_id" {
   description = "value for ami_id"
 }

 variable "instance_type" {
   description = "value instnace type"
 }

variable "key_pair" {
  default = "value for key_pair"
}

variable "private_ami_id" {
  description = "value for ami_id"
}

variable "private_ec2_type" {
  description = "value instnace type"
}

variable "private_ec2_key_name" {
  description = "value for key_name"
}

