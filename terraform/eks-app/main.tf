provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_eks_cluster" "main" {
  count = var.deploy_eks == true ? 0 : 1
  name  = var.eks_cluster_name
}


locals {
  account_id         = data.aws_caller_identity.current.account_id
  vpc_id             = var.create_vpc == true ? module.shared_vpc[0].vpc_id : var.vpc_id
  public_subnet_ids  = var.create_vpc == true ? module.shared_vpc[0].public_subnet_ids : var.public_subnet_ids
  private_subnet_ids = var.create_vpc == true ? module.shared_vpc[0].private_subnet_ids : var.private_subnet_ids
  database_az        = var.create_vpc == true ? module.shared_vpc[0].az_1 : data.aws_availability_zones.available.names[0]
  eks_oidc_issuer    = var.deploy_eks == true ? aws_eks_cluster.main[0].identity[0].oidc[0].issuer : data.aws_eks_cluster.main[0].identity[0].oidc[0].issuer
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }

    grafana = {
      source  = "grafana/grafana"
      version = "~> 1.12.0"
    }

    auth0 = {
      source = "alexkappa/auth0"
    }
  }

  required_version = ">= 0.14.9"

  //
  // Optional S3 backend
  //
  //  backend "s3" {
  //    bucket  = "STATE_BUCKET"
  //    key     = "STATE_PATH/terraform.tfstate"
  //    region  = "REGION"
  //  }

}
