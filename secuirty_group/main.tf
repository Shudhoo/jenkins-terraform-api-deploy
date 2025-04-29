variable "vpc_id" {}
variable "public_subnet_cidr" {}

# out put 
output "proj_public_sg_ec2_output" {
  value = aws_security_group.proj_public_sg_ec2.id
}
# Security for Public EC2 server
resource "aws_security_group" "proj_public_sg_ec2" {
    vpc_id = var.vpc_id
    description = "This is my Security Group for Web-Server"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow SSH from anywhere[not recommended]"
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP from anywhere"
    }
    ingress {
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow traffic to Application on port 5000"
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Outbond Trffic to anywhere"
    }

    tags = {
      Name = "SG_for_public_ec2"
    }
  
}

# Output for Private SG
output "proj_private_sg_ec2_output" {
  value = aws_security_group.proj_private_sg_ec2.id
}

# Security for Private EC2 server
resource "aws_security_group" "proj_private_sg_ec2" {
  vpc_id = var.vpc_id
  description = "This is my Security Group for App-Server"

  ingress {
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    cidr_blocks = []
    security_groups = [aws_security_group.proj_public_sg_ec2.id]
    description = "Allows Connection between web-server and app-server"
  }
}


# Output for RDS SG
output "proj_sg_rds_output" {
  value = aws_security_group.proj_sg_rds.id
}

# Security Group for RDS
resource "aws_security_group" "proj_sg_rds" {
  vpc_id = var.vpc_id
  description = "This is Security-Group for RDS Database"

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = []
    security_groups = [aws_security_group.proj_private_sg_ec2.id]
    description = "Allows Traffic from Public-Subnets only"
  }

  tags = {
    Name = "SG_for_rds"
  }
}