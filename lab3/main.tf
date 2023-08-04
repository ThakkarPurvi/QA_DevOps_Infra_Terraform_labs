provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "eu-west-2"
}
resource "aws_instance" "demo_using_var" {
  ami           = "ami-0fb391cce7a602d1f"
  instance_type = "t2.micro"
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = var.bucket_name
}

output "vm_public_ip" {
  value = aws_instance.demo_using_var.public_ip
}

output "s3_domain" {
  value = aws_s3_bucket.demo_bucket.bucket_domain_name
}
