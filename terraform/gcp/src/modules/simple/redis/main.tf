locals {
  name_prefix = "${var.app_name}-${var.environment}"
}

resource "google_redis_instance" "cache" {
  name               = "${local.name_prefix}-${var.cache_name}"
  memory_size_gb     = 1
  authorized_network = var.network_id
}