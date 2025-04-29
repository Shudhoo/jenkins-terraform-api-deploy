# Here will be all the modules listed 

# Networking Module
module "networking" {
  source = "./networking"
  vpc_cidr = var.vpc_cidr_my
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  azs = var.azs
}

# Security-Group Module
module "aws_security_group" {
  source = "./secuirty_group"
  vpc_id = module.networking.vpc_output
  public_subnet_cidr = tolist(module.networking.public_subnet_cidr_block)
}

# Public EC2 Module
module "public_ec2" {
  source = "./public-ec2"
  ec2_name = "Public_EC2_Server"
  ami_id = var.ami_id
  ec2_type = var.instance_type
  key_pair = var.key_pair
  subnet_ids = tolist(module.networking.public_subnet_output)
  sg_ids = module.aws_security_group.proj_public_sg_ec2_output
  enable_public_id = true
}

# Private EC2 Module
module "private_ec2" {
  source = "./private-ec2"
  private_ec2_name = "Private_EC2_Server"
  private_ec2_ami = var.private_ami_id
  private_ec2_type = var.private_ec2_type
  private_key_pair = var.private_ec2_key_name
  private_ec2_subnet_ids = tolist(module.networking.private_subnet_output)
  private_sg = module.aws_security_group.proj_private_sg_ec2_output
  private_associate_public_ip_address = false
}

#RDS Module
module "rds" {
  source = "./rds"
  db_subnet_grp_name = "proj_rds_db_subnet_grp"
  subnet_group = tolist(module.networking.private_subnet_output)
  db_identifier = "proj-rds"
  urs_name = "admin"
  passwd = "adminadmin"
  sg_rds = module.aws_security_group.proj_sg_rds_output
  db_name = "admin"
}

# Load Balancer Target Group
module "load_balancer_target_group" {
  source = "./load_balance_target_group"
  target_grp_name = "proj-lb-target-group"
  target_grp_port = 5000
  target_grp_protocol = "HTTP"
  vpc_id = module.networking.vpc_output
  ec2_id = tolist(module.public_ec2.ec2_public_id)
}

# Load Balancer
module "load_balancer" {
  source = "./load_balancer"
  lb_name = "proj-load-balancer"
  is_external = false
  lb_type = "application"
  sg = module.aws_security_group.proj_public_sg_ec2_output
  subnet_ids = tolist(module.networking.public_subnet_output)
  tag_name = "proj-lb"
  lb_target_grp_arn = module.load_balancer_target_group.target_group_output
  ec2_id = tolist(module.public_ec2.ec2_public_id)
  lb_listner_port = 80
  lb_listner_protocol = "HTTP"
  lb_listner_default_action = "forward"
  lb_target_grp_attchment_port = 5000
}