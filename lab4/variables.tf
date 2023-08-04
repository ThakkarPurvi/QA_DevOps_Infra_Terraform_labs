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
  default = "lab_4_key_pair"
}

variable "public_key_path" {
  default = "~/.ssh/lab_4_key.pub"
}

variable "vpc_id" {
  default = "vpc-id123"
}


variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-0eb260c4d5475b901"
}

variable "security_group_name" {
  default = "lab4_security_group"
}
