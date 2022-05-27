provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

terraform {
  backend "s3" {
    bucket = "modernlogic-terraform-state-prod"
    key    = "shieldrule-specific/terraform.tfstate"
    region = "us-west-1"
  }
}
