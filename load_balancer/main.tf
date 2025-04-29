variable "lb_name" {}
variable "is_external" { default = false}
variable "lb_type" {}
variable "sg" {}
variable "subnet_ids" {}
variable "tag_name" {}
variable "lb_target_grp_arn" {}
variable "ec2_id" {}
variable "lb_listner_port" {}
variable "lb_listner_protocol" {}
variable "lb_listner_default_action" {}
variable "lb_target_grp_attchment_port" {}


# Load Balancer
resource "aws_lb" "proj_lb" {
  name = var.lb_name
  internal = var.is_external
  load_balancer_type = var.lb_type
  security_groups = [var.sg]
  subnets = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "proj_lb"
  }
}

# Attachment target Group 
resource "aws_lb_target_group_attachment" "proj_lb_target_group_attachment" {
  count = length(var.ec2_id)
  target_group_arn = var.lb_target_grp_arn
  target_id = element(var.ec2_id, count.index)
  port = var.lb_target_grp_attchment_port
}

# LB Listners
resource "aws_lb_listener" "proj_lb_listners" {
  load_balancer_arn = aws_lb.proj_lb.arn
  port = var.lb_listner_port
  protocol = var.lb_listner_protocol

  default_action {
    type = var.lb_listner_default_action
    target_group_arn = var.lb_target_grp_arn
  }
}