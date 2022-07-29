locals {
  name_prefix = "${var.app_name}-${var.environment}"
  app_name    = "${local.name_prefix}-${var.app_name}"
}

resource "google_cloud_run_service" "main" {
  name     = local.app_name
  location = var.location
  project  = var.project_id

  template {
    spec {
      containers {
        image = "${var.location}-docker.pkg.dev/shieldrule-dev-project/${var.image}:${var.image_tag}"
        //        image = "${var.image}:${var.image_tag}"
        env {
          name  = "SOURCE"
          value = "remote"
        }
        env {
          name  = "TARGET"
          value = "home"
        }
        ports {
          container_port = 8000
        }
      }
    }
  }
  //
  //  metadata {
  //    name = local.app_name
  //  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}