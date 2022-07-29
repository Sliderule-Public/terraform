locals {
  name_prefix = "${var.app_name}-${var.environment}"
}

resource "google_artifact_registry_repository" "main" {
  provider      = google-beta
  project       = var.project_id
  location      = var.location
  repository_id = "${local.name_prefix}-${var.image_name}"
  format        = "DOCKER"
}