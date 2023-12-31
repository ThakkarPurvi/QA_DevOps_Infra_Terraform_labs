resource "aws_security_group" "lab6_ec2_security_group" {
  name        = "lab6_ec2_security_group"
  description = "Security group for EC2"

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_security_group" "lab6_rds_security_group" {
  name        = "lab6_rds_security_group"
  description = "Security group for RDS"
}

resource "aws_security_group_rule" "lab6_ec2_to_rds_security_group" {
  security_group_id        = aws_security_group.lab6_ec2_security_group.id
  type                     = "egress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lab6_rds_security_group.id
}


resource "aws_security_group_rule" "lab6_rds_to_ec2_security_group" {
  security_group_id        = aws_security_group.lab6_rds_security_group.id
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lab6_ec2_security_group.id
}

resource "aws_instance" "lab6_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = "TF_key"
  user_data_replace_on_change = true
  user_data                   = <<-EOF
      #!/bin/bash
      sudo apt-get update -y
      sudo apt-get install mysql-client -y
      EOF
  vpc_security_group_ids      = [aws_security_group.lab6_ec2_security_group.id]
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "my-subnet-group"
  subnet_ids = ["subnet-00f7299a6ff9926a6", "subnet-075b303a24ae96489"]
}

resource "aws_db_instance" "db_instance" {
  engine                 = "mysql"
  instance_class         = "db.t2.micro"
  username               = "admin"
  password               = "password"
  allocated_storage      = "20"
  storage_type           = "gp2"
  publicly_accessible    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.lab6_rds_security_group.id]
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
}

output "ec2_public_ip_for_mysql" {
  value = aws_instance.lab6_instance.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.db_instance.endpoint
}

