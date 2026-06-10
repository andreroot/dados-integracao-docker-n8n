resource "aws_vpc" "db-pentecoste_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "db-pentecoste-ec2-vpc"
  }
}

resource "aws_subnet" "db-pentecoste_subnet" {
  vpc_id                  = aws_vpc.db-pentecoste_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "db-pentecoste-ec2-subnet"
  }
}

resource "aws_internet_gateway" "db-pentecoste_igw" {
  vpc_id = aws_vpc.db-pentecoste_vpc.id

  tags = {
    Name = "db-pentecoste-ec2-igw"
  }
}

resource "aws_route_table" "db-pentecoste_route_table" {
  vpc_id = aws_vpc.db-pentecoste_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.db-pentecoste_igw.id
  }

  tags = {
    Name = "db-pentecoste-ec2-rt"
  }
}

resource "aws_route_table_association" "db-pentecoste_route_table_assoc" {
  subnet_id      = aws_subnet.db-pentecoste_subnet.id
  route_table_id = aws_route_table.db-pentecoste_route_table.id
}