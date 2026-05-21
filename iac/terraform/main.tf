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

resource "aws_s3_bucket" "demo" {
  bucket = "ben-bucket"

  tags = {
    Name    = "ben-bucket"
    Owner   = var.owner_name
    Email   = var.owner_email
  }
}

output "bucket_name" {
  value = aws_s3_bucket.demo.bucket
}
