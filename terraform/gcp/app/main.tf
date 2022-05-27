provider "google" {
  region = "us-west1"
}

locals {
  environment = terraform.workspace
  app_name    = "shieldrule"
  org_id      = "700483480583"
  name_prefix = "${local.app_name}-${local.environment}"
  region = "us-west1"
  billing_account = var.billing_account
}

module "google_project" {
  source      = "../src/modules/simple/google_project"
  app_name    = local.app_name
  environment = local.environment
  org_id      = local.org_id
  billing_account = local.billing_account
}