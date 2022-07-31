terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.23.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
  }

  backend "s3" {
    bucket = "web-resume-anna-kozar-tfstate"
    key    = "backend/tfstate"
    region = "us-east-1"
  }

  required_version = "~> 1.0"
}

provider "aws" {
  region = var.aws_region
  profile    = "default"
}



resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "web-resume-anna-kozar-backend"

  force_destroy = true
}




