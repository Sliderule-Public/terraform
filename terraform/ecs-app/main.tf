provider "aws" {
  region = var.region
}

provider "grafana" {
  url  = "https://usemodernlogic.grafana.net/"
  auth = var.grafana_auth
}

data "aws_caller_identity" "current" {}

data "aws_route53_zone" "selected" {
  count   = var.deploy_route53_resources == true ? 1 : 0
  zone_id = var.zone_id
}


locals {
  account_id              = data.aws_caller_identity.current.account_id
  web_subdomain           = var.environment == "prod" ? "app" : var.environment
  api_subdomain           = var.environment == "prod" ? "api" : "api-${var.environment}"
  docs_subdomain          = var.environment == "prod" ? "docs-temp" : "docs-${var.environment}"
  root_domain             = var.deploy_route53_resources == true ? data.aws_route53_zone.selected[0].name : var.domain
  formatted_web_hostname  = "${local.web_subdomain}.${local.root_domain}"
  formatted_api_hostname  = "${local.api_subdomain}.${local.root_domain}"
  formatted_docs_hostname = "${local.docs_subdomain}.${local.root_domain}"
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
      source  = "alexkappa/auth0"
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
