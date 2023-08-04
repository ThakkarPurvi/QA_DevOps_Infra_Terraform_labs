
variable "access_key" {
  default = "AKIAYKIRSUU2HFFJZTOY"
}

variable "secret_key" {
  default = "tYYAm0FNAyoJ2DXBxhNDySWujNngAFkHfngF+B0d"
}

variable "aws_region" {
  default = "eu-west-2"
}

variable "key_pair_name" {
  default = "lab_5_key_pair"
}

variable "public_key_path" {
  default = "~/.ssh/lab_5_key.pub"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-0eb260c4d5475b901"
}

variable "security_group_name" {
  default = "lab5_security_group"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  default     = "10.10.0.0/20"
}

variable "subnet_1_cidr_blocks" {
  description = "CIDR blocks for subnets"
  default     = "10.10.0.0/24"
}


variable "subnet_2_cidr_blocks" {
  description = "CIDR blocks for subnets"
  default     = "10.10.1.0/24"
}

variable "ssh_allowed_ip" {
  description = "IP address - SSH to EC2."
  default     = "0.0.0.0/0"
}

variable "http_allowed_ip" {
  description = "IP address - HTTP to EC2."
  default     = "0.0.0.0/0"
}

variable "sql_allowed_ip" {
  description = "IP address - SQL to EC2."
  default     = "0.0.0.0/0"
}

