terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta2", # Use the latest beta version for testing
    }
  }
 
}

provider "aws" {
  region = "us-east-1"
}