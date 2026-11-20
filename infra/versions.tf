terraform {
  required_version = ">= 1.6.0, < 2.0.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.0, < 7.0"
    }
  }
}

# Credentials are intentionally NOT defined here.
# Terraform uses the local AWS profile if you choose to apply.

provider "aws" {
  region = var.aws_region
}

