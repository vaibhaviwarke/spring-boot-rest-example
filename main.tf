terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "TF-vpc" {
  cidr_block = "10.20.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "TF-VPC"
  }
}

# Create Public Subnet
resource "aws_subnet" "TF-public-subnet" {
  vpc_id                  = aws_vpc.TF-vpc.id
  cidr_block              = "10.20.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "TF-public-subnet-1a"
  }
}

# Create Public Subnet
resource "aws_subnet" "TF-public-subnet-1" {
  vpc_id                  = aws_vpc.TF-vpc.id
  cidr_block              = "10.20.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "TF-public-subnet-1b"
  }
}

# Create Pvt Subnet
resource "aws_subnet" "TF-pvt-subnet-1" {
  vpc_id                  = aws_vpc.TF-vpc.id
  cidr_block              = "10.20.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "TF-private-subnet-1a"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.TF-vpc.id

  tags = {
    Name = "TF-IGW"
  }
}

# Create Web layber route table
resource "aws_route_table" "TF-public-rt" {
  vpc_id = aws_vpc.TF-vpc.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "TF-public-RT"
  }
}

# Create Web Subnet association with public route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.TF-public-subnet.id
  route_table_id = aws_route_table.TF-public-rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.TF-public-subnet-1.id
  route_table_id = aws_route_table.TF-public-rt.id
}

# Create Security Group
resource "aws_security_group" "TF-sg" {
  name        = "Web-SG"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.TF-vpc.id

  ingress {
    description = "Allow all traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "Allow traffic for RDS MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TF-SG"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.default.id
  engine                 = "mysql"
  engine_version         = "8.0.20"
  instance_class         = "db.t2.micro"
  multi_az               = false
  publicly_accessible	 = true
  name                   = "TF-MySQL-DB"
  username               = "admin"
  password               = "admin123"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.TF-sg.id]
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.TF-public-subnet.id, aws_subnet.TF-public-subnet-1.id, aws_subnet.TF-pvt-subnet-1.id]

  tags = {
    Name = "My DB subnet group"
  }
}
