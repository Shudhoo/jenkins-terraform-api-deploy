variable "vpc_cidr" {
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



output "vpc_output" {
   value = aws_vpc.proj_vpc.id
 }
resource "aws_vpc" "proj_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "proj_vpc"
  }
}
# Output for Public Subnet Id's and CIDR Blocks
output "public_subnet_output" {
  value = aws_subnet.proj_public_subnet.*.id
 }
 
output "public_subnet_cidr_block" {
  value = aws_subnet.proj_public_subnet.*.cidr_block
}
resource "aws_subnet" "proj_public_subnet" {
    vpc_id = aws_vpc.proj_vpc.id
    count = length(var.public_subnet_cidr)
    cidr_block = element(var.public_subnet_cidr, count.index)
    availability_zone = element(var.azs, count.index)
    
    tags = {
      Name = "proj_public_subnet${count.index +1}"
    }
}

# Output for Private Subnet Id's
output "private_subnet_output" {
  value = aws_subnet.proj_private_subnet.*.id
}
resource "aws_subnet" "proj_private_subnet" {
    vpc_id = aws_vpc.proj_vpc.id
    count = length(var.private_subnet_cidr)
    cidr_block = element(var.private_subnet_cidr, count.index)
    availability_zone = element(var.azs, count.index)

    tags = {
      Name = "proj_private_subnet${count.index +1}"
    }
}

resource "aws_internet_gateway" "proj_igw" {
    vpc_id = aws_vpc.proj_vpc.id

    tags = {
      Name = "proj_igw"
    }
}

resource "aws_route_table" "proj_public_rt" {
  vpc_id = aws_vpc.proj_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.proj_igw.id
  }

  tags = {
    Name = "proj_public_rt"
  }
}

resource "aws_route_table" "proj_private_rt" {
  vpc_id = aws_vpc.proj_vpc.id
  #depends_on = [ aws_nat_gateway ]

  tags = {
    Name = "proj_private_rt"
  }
}

# This is Public Route Table Association
resource "aws_route_table_association" "proj_public_rt_association" {
  count = length(aws_subnet.proj_public_subnet)
  subnet_id = aws_subnet.proj_public_subnet[count.index].id
  route_table_id = aws_route_table.proj_public_rt.id
}

# This is Private Route table Association 
resource "aws_route_table_association" "proj_private_rt_association" {
  count = length(aws_subnet.proj_private_subnet)
  subnet_id = aws_subnet.proj_private_subnet[count.index].id
  route_table_id = aws_route_table.proj_private_rt.id
}

