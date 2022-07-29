locals {
  name_prefix = "${var.app_name}-${var.environment}"
}

resource "google_pubsub_topic" "main" {
  name                       = "${local.name_prefix}-${var.topic_name}"
  message_retention_duration = "86600s"
  project                    = var.project_id
}