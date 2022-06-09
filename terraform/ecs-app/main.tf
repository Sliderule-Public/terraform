provider "aws" {
  region = var.region
}

provider "grafana" {
  url  = "https://usemodernlogic.grafana.net/"
  auth = var.grafana_auth
}

data "aws_caller_identity" "current" {}

data "aws_route53_zone" "selected" {
  count   = var.deploy_route53_resources == true ? length(var.hosted_zone_ids) : 0
  zone_id = var.hosted_zone_ids[count.index]
}


locals {
  account_id           = data.aws_caller_identity.current.account_id
  zone_names           = [for zone in data.aws_route53_zone.selected : zone.name]
  web_domains          = flatten([for subdomain in var.web_subdomains : [for name in local.zone_names : "${subdomain}.${name}"]])
  api_domains          = flatten([for subdomain in var.api_subdomains : [for name in local.zone_names : "${subdomain}.${name}"]])
  docs_domains         = flatten([for subdomain in var.docs_subdomains : [for name in local.zone_names : "${subdomain}.${name}"]])
  web_route53_entries  = flatten([for subdomain in var.web_subdomains : [for id in var.hosted_zone_ids : { subdomain : subdomain, id : id }]])
  api_route53_entries  = flatten([for subdomain in var.api_subdomains : [for id in var.hosted_zone_ids : { subdomain : subdomain, id : id }]])
  docs_route53_entries = flatten([for subdomain in var.docs_subdomains : [for id in var.hosted_zone_ids : { subdomain : subdomain, id : id }]])
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
