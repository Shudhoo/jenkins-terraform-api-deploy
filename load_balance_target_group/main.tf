variable "target_grp_name" {}
variable "target_grp_port" {}
variable "target_grp_protocol" {}
variable "vpc_id" {}
variable "ec2_id" {}

# Output for LB Target Group
output "target_group_output" {
  value = aws_lb_target_group.proj_lb_target_group.arn
}
resource "aws_lb_target_group" "proj_lb_target_group" {
  name = var.target_grp_name
  port = var.target_grp_port
  protocol = var.target_grp_protocol
  vpc_id = var.vpc_id
  
  health_check {
    path = "/health"
    port = 5000
    healthy_threshold = 6
    unhealthy_threshold = 2
    timeout = 2
    interval = 5
    matcher = "200"
  }
}

resource "aws_lb_target_group_attachment" "proj_lb_target_group_attachment" {
  target_group_arn = aws_lb_target_group.proj_lb_target_group.arn
  target_id = var.ec2_id
  port = 5000
}
