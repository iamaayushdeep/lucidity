terraform {
  required_version = ">= 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.52"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Terraform  = "true"
      Environment = "dev"
    }
  }
}