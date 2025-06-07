# provider.tf
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0" # Make sure this matches a compatible version from registry.terraform.io
    }
  }
}

provider "aws" {
  region = "us-east-1"
}