provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.aws_region
}

resource "aws_security_group" "lab4_security_group" {
  name        = var.security_group_name
  description = "Security group for lab 4"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    project = "lab_4"
  }
}

resource "aws_instance" "lab4_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = "TF_key"
  vpc_security_group_ids = [aws_security_group.lab4_security_group.id]

  tags = {
    project = "lab_4"
  }
}


resource "aws_key_pair" "TF_key" {
  key_name   = "TF_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "TF_key" {
  content         = tls_private_key.rsa.private_key_pem
  filename        = "TF_key"
  file_permission = "400"
}


output "vm_public_ip" {
    value = aws_instance.lab4_instance.public_ip
}
