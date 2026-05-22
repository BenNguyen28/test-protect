terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "day25_sg" {
  name        = "day25-pipeline-sg"
  description = "Allow SSH"

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

  tags = {
    Name  = "day25-pipeline-sg"
    Owner = var.owner_name
    Email = var.owner_email
  }
}

resource "aws_instance" "demo" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = "ben-key"
  vpc_security_group_ids = [aws_security_group.day25_sg.id]

  tags = {
    Name  = "proops2026-day25-pipeline-test"
    Owner = var.owner_name
    Email = var.owner_email
  }
}

output "instance_public_ip" {
  value = aws_instance.demo.public_ip
}

output "instance_id" {
  value = aws_instance.demo.id
}
