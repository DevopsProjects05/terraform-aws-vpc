terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta2", # Use the latest beta version for testing
    }
  }

  backend "s3" {
    bucket         = "roboshop-bucket-123"
    key            = "dev/vpc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "Roboshop-tfstate-locks"
  }
}

provider "aws" {
  region = "us-east-1"
}