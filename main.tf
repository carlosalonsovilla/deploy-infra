provider "aws" {
    region = "us-east-1"  
}

#Fetch default VPC
data "aws_vpc" "default" {
  default = true
  
}

#Generate a private key
resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits = "4096"
}

#Upload the public key to AWS for SSH access
resource "aws_key_pair" "my_key_pair" {
  key_name = "my-terraform_key"
  public_key = tls_private_key.my_key.public_key_openssh
}

#Save the private key locally
resource "local_file" "private_key" {
  content = tls_private_key.my_key.private_key_pem
  filename = "${path.module}/my_terraform-key.pem"
  file_permission = "0400"
}

#Create a security group that allows SSH from your machine
resource "aws_security_group" "ec2_ssh" {
  name = "Allow ssh"
  description = "Only allow ssh from my VM"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/32"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Launch the EC2 instance 
resource "aws_instance" "my_ec2" {
  ami = "ami-06b21ccaeff8cd686"
  instance_type =  "t2.micro"
  key_name = aws_key_pair.my_key_pair.key_name
  security_groups = [aws_security_group.ec2_ssh.name]

  tags = {
    Name = "MyTerraformEC2"
  }
}

#Output the location of the private key file
output "private_key_path" {
  value = local_file.private_key.filename
  sensitive = true
}