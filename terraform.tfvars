# This all variables are of Networking [VPC, Subnets, Route Table, Rout Table Associations, Internet Gateway]
vpc_cidr_my= "11.0.0.0/16"
public_subnet_cidr = ["11.0.1.0/24","11.0.2.0/24"]
private_subnet_cidr = ["11.0.3.0/24","11.0.4.0/24"]
azs = ["us-west-2a","us-west-2b"]

# EC2 variables
ami_id = ["ami-075686beab831bb7f","ami-075686beab831bb7f"]
instance_type = "t2.micro"
key_pair = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP0sMfsSdWUikmzxZ2ZJFctd+KhfrTJvm+7j8rpnBA2u shudho@Lap"
private_ami_id = ["ami-075686beab831bb7f"]
private_ec2_type = "t2.medium"
private_ec2_key_name = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMMOtkZwHW9POssoLST1bwHO/wXfdGqBeIVc9osyantk shudho@Lap"
