provider "aws" {
  region = "us-east-1" 
}

# Make the vpc 

resource "aws_vpc" "avish_terraform_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "AvishTerraformVPC"
  }
}

#make subnet in above vpc 
resource "aws_subnet" "avish_terraform_subnet" {
  vpc_id = aws_vpc.avish_terraform_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "AvishTerraformSubnet"
  }
}

# make internet gateway
resource "aws_internet_gateway" "avish_terraform_gateway" {
  vpc_id = aws_vpc.avish_terraform_vpc.id
  tags = {
    Name = "AvishTerraformGateway"
  }
}

# make route table
resource "aws_route_table" "avish_terraform_route_table" {
  vpc_id = aws_vpc.avish_terraform_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.avish_terraform_gateway.id
  }
  tags = {
    Name = "AvishTerraformRouteTable"
  }
}

# associate route table with subnet
resource "aws_route_table_association" "avish_terraform_association" {
  subnet_id      = aws_subnet.avish_terraform_subnet.id
  route_table_id = aws_route_table.avish_terraform_route_table.id
}

# make security group
resource "aws_security_group" "avish_terraform_security_group" {
  name = "AvishTerraformSecurityGroup"
  description = "Allow SSH access"
  vpc_id = aws_vpc.avish_terraform_vpc.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["125.23.34.124/32"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["18.206.107.24/29"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "AvishTerraformSecurityGroup"
  }
}

# make ec2 instance
resource "aws_instance" "avish_terraform_instance" {
  ami = "ami-06b21ccaeff8cd686"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.avish_terraform_subnet.id
  vpc_security_group_ids = [aws_security_group.avish_terraform_security_group.id]
  tags = {
    Name = "AvishTerraformInstance"
  }
}

