provider "aws" {
  region = var.region
}

provider "grafana" {
  url  = "https://usemodernlogic.grafana.net/"
  auth = var.grafana_auth
}

data "aws_caller_identity" "current" {}

data "aws_route53_zone" "ecs_domain_names" {
  count   = var.deploy_route53_resources == true ? length(var.ecs_domain_names) : 0
  name = var.ecs_domain_names[count.index]
}

data "aws_route53_zone" "extra_domain_names" {
  count   = var.deploy_route53_resources == true ? length(var.extra_domain_names) : 0
  name = var.extra_domain_names[count.index]
}


locals {
  account_id          = data.aws_caller_identity.current.account_id
  ecs_domains         = [for zone in data.aws_route53_zone.ecs_domain_names : zone.name]
  extra_domains       = [for zone in data.aws_route53_zone.extra_domain_names : zone.name]
  all_domains         = concat(local.ecs_domains, local.extra_domains)
  all_zone_ids        = concat([for zone in data.aws_route53_zone.ecs_domain_names : zone.id], [for zone in data.aws_route53_zone.extra_domain_names : zone.id])
  ecs_web_domains     = flatten([for subdomain in var.web_subdomains : [for name in local.ecs_domains : "${subdomain}.${name}"]])
  ecs_api_domains     = flatten([for subdomain in var.api_subdomains : [for name in local.ecs_domains : "${subdomain}.${name}"]])
  web_route53_entries = flatten([for subdomain in var.web_subdomains : [for id in local.all_zone_ids : { subdomain : subdomain, id : id }]])
  api_route53_entries = flatten([for subdomain in var.api_subdomains : [for id in local.all_zone_ids : { subdomain : subdomain, id : id }]])
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }

    grafana = {
      source  = "grafana/grafana"
      version = "~> 1.15.0"
    }

    auth0 = {
      source = "alexkappa/auth0"
    }
  }

  required_version = ">= 0.14.9"

#  backend "s3" {}
}
