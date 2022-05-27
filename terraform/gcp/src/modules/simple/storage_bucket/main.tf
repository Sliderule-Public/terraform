locals {
  name_prefix = "${var.app_name}-${var.environment}"
}

resource "google_storage_bucket" "bucket" {
  name                        = "${local.name_prefix}-${var.bucket_name}"
  uniform_bucket_level_access = var.uniform_bucket_level_access
  location                    = "US"
  project                     = var.project_id
}