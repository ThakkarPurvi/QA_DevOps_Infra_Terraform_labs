provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.aws_region
}

resource "aws_security_group" "lab5_security_group" {
  name        = var.security_group_name
  description = "Security group for lab 5"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "lab5_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = "TF_key"
  vpc_security_group_ids = [aws_security_group.lab5_security_group.id]
  subnet_id		 = aws_subnet.subnet_1.id

  tags = {
    project = "lab_5"
  }
}

output "vm_public_ip" {
  value = aws_instance.lab5_instance.public_ip
}


#. vpc
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "MyVPC"
  }
}

# public subnets 1
resource "aws_subnet" "subnet_1" {
  cidr_block              = var.subnet_1_cidr_blocks
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet_1"
  }
}

# public subnet 2
resource "aws_subnet" "subnet_2" {
  cidr_block              = var.subnet_2_cidr_blocks
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet_2"
  }
}

# internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "MyIGW"
  }
}

# route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

#  public subnets 1 with the public route
resource "aws_route_table_association" "subnet_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.public.id
}

#  public subnets 2 with the public route
resource "aws_route_table_association" "subnet_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.public.id
}

