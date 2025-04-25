variable "db_subnet_grp_name" {}
variable "subnet_group" {}
variable "db_identifier" {}
variable "urs_name" {}
variable "passwd" {}
variable "sg_rds" {}
variable "db_name" {}

# This is RDS Subnet Group
resource "aws_db_subnet_group" "proj_db_subnet_grp" {
  name = var.db_subnet_grp_name
  subnet_ids = var.subnet_group
}

# Output RDS Endpoint
output "rds_endpoint" {
  value = aws_db_instance.proj_db_rds.endpoint
}

resource "aws_db_instance" "proj_db_rds" {
    allocated_storage = 10
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "5.7"
    instance_class = "db.t3.micro"
    identifier = var.db_identifier
    username = var.urs_name
    password = var.passwd
    vpc_security_group_ids = [var.sg_rds]
    db_subnet_group_name = aws_db_subnet_group.proj_db_subnet_grp.name
    db_name = var.db_name
    skip_final_snapshot = true
    apply_immediately = true
    backup_retention_period = 0
    deletion_protection = false

}
