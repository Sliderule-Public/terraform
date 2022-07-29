provider "google" {
  region = "us-west1"
}

locals {
  app_name        = "shieldrule"
  org_id          = "700483480583"
  region          = "us-west1"
  billing_account = var.billing_account
}