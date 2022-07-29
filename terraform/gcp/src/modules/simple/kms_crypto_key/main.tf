locals {
  name_prefix = "${var.app_name}-${var.environment}"
}

resource "google_kms_key_ring" "keyring" {
  name     = local.name_prefix
  location = "global"
  project  = var.project_id
}

resource "google_kms_crypto_key" "main" {
  name            = local.name_prefix
  key_ring        = google_kms_key_ring.keyring.id
  rotation_period = "100000s"

  lifecycle {
    prevent_destroy = true
  }
}