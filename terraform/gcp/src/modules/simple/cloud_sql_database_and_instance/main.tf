locals {
  name_prefix = "${var.app_name}-${var.environment}"
}

resource "google_sql_database" "database" {
  name     = "${local.name_prefix}-${var.db_name}"
  instance = google_sql_database_instance.instance.name
  project  = var.project_id
}

resource "google_sql_database_instance" "instance" {
  name             = "${local.name_prefix}-${var.db_name}"
  database_version = var.db_version
  project          = var.project_id
  settings {
    tier = var.db_tier

    ip_configuration {
      ipv4_enabled    = true
      private_network = var.network_id
      require_ssl     = true
    }
  }

  depends_on = [google_service_networking_connection.private_vpc_connection]

  deletion_protection = "true"
}

resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  project       = var.project_id
  network       = var.network_id
}

// TODO this will take some kind of input from Cloud Run
resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = var.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}