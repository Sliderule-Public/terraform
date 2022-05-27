locals {
  name_prefix = "${var.app_name}-${var.environment}"
}

resource "google_compute_network" "vpc" {
  name    = local.name_prefix
  project = var.project_id
}