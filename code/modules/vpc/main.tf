# VPC
resource "aws_vpc" "demo_vpc" {
    cidr_block = "${var.vpc_ipv4_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "demo-vpc"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "demo-igw"
  }
}

# NACL
resource "aws_network_acl" "demo_nacl" {
  vpc_id = aws_vpc.demo_vpc.id

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "demo-nacl"
  }
}

# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.demo_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw.id
  }
}

# Public Subnet 2a
resource "aws_subnet" "public_subnet_2a" {
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = "${var.public_subnet_2a_ipv4_cidr}"
    availability_zone = "ap-northeast-2a"
    tags = {
        Name = "demo-public-subent-2a"
    }
}

# Public Subnet 2c
resource "aws_subnet" "public_subnet_2c" {
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = "${var.public_subnet_2c_ipv4_cidr}"
    availability_zone = "ap-northeast-2c"
    tags = {
        Name = "demo-public-subent-2c"
    }
}

# Public Route Table Association 2a
resource "aws_route_table_association" "public_route_table_asso_2a" {
  subnet_id = aws_subnet.public_subnet_2a.id
  route_table_id = aws_route_table.public_route_table.id
}

# Public Route Table Association 2c
resource "aws_route_table_association" "public_route_table_asso_2c" {
  subnet_id = aws_subnet.public_subnet_2c.id
  route_table_id = aws_route_table.public_route_table.id
}

# Elastic IP for NAT Gateway - 2a
resource "aws_eip" "demo_eip_2a" {
  domain = "vpc"
}

# NAT Gateway - 2a
resource "aws_nat_gateway" "demo_nat_gw_2a" {
  allocation_id = aws_eip.demo_eip_2a.id
  subnet_id = aws_subnet.public_subnet_2a.id
  tags = {
    Name = "demo_nat_gateway_2a"
  }
}

# Elastic IP for NAT Gateway - 2c
resource "aws_eip" "demo_eip_2c" {
  domain = "vpc"
}

# NAT Gateway - 2c
resource "aws_nat_gateway" "demo_nat_gw_2c" {
  allocation_id = aws_eip.demo_eip_2c.id
  subnet_id = aws_subnet.public_subnet_2c.id
  tags = {
    Name = "demo_nat_gateway_2c"
  }
}

# Private Route Table - 2a
resource "aws_route_table" "private_route_table_2a" {
  vpc_id = aws_vpc.demo_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.demo_nat_gw_2a.id
  }
}

# Private Route Table - 2c
resource "aws_route_table" "private_route_table_2c" {
  vpc_id = aws_vpc.demo_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.demo_nat_gw_2c.id
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet_2a" {
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = "${var.private_subnet_2a_ipv4_cidr}"
    availability_zone = "ap-northeast-2a"
    tags = {
        Name = "demo-private-subent-2a"
    }
}

# Private Subnet
resource "aws_subnet" "private_subnet_2c" {
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = "${var.private_subnet_2c_ipv4_cidr}"
    availability_zone = "ap-northeast-2c"
    tags = {
        Name = "demo-private-subent-2c"
    }
}

# Private Route Table Association 2a
resource "aws_route_table_association" "private_route_table_asso_2a" {
  subnet_id = aws_subnet.private_subnet_2a.id
  route_table_id = aws_route_table.private_route_table_2a.id
}

# Private Route Table Association 2c
resource "aws_route_table_association" "private_route_table_asso_2c" {
  subnet_id = aws_subnet.private_subnet_2c.id
  route_table_id = aws_route_table.private_route_table_2c.id
}