resource "grafana_data_source" "cloudwatch" {
  count = var.deploy_grafana_resources ? 1 : 0
  type  = "cloudwatch"
  name  = "terraform-cloudwatch-${var.environment}"

  json_data {
    default_region = var.region
    auth_type      = "keys"
  }

  secure_json_data {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
  }
}

resource "grafana_dashboard" "metrics_api" {
  count       = var.deploy_grafana_resources ? 1 : 0
  config_json = file("grafana-${var.environment}/ecs-dashboard-api.json")
  depends_on  = [grafana_data_source.cloudwatch[0]]
}
resource "grafana_dashboard" "metrics_web" {
  count       = var.deploy_grafana_resources ? 1 : 0
  config_json = file("grafana-${var.environment}/ecs-dashboard-web.json")
  depends_on  = [grafana_data_source.cloudwatch[0]]
}
resource "grafana_dashboard" "metrics_docs" {
  count       = var.deploy_grafana_resources ? 1 : 0
  config_json = file("grafana-${var.environment}/ecs-dashboard-docs.json")
  depends_on  = [grafana_data_source.cloudwatch[0]]
}
resource "grafana_dashboard" "redis" {
  count       = var.deploy_grafana_resources ? 1 : 0
  config_json = file("grafana-${var.environment}/redis.json")
  depends_on  = [grafana_data_source.cloudwatch[0]]
}
resource "grafana_dashboard" "sqs" {
  count       = var.deploy_grafana_resources ? 1 : 0
  config_json = file("grafana-${var.environment}/sqs.json")
  depends_on  = [grafana_data_source.cloudwatch[0]]
}

resource "grafana_alert_notification" "email" {
  count         = var.deploy_grafana_resources ? 1 : 0
  name          = "Email channel ${var.environment}"
  type          = "email"
  is_default    = true
  send_reminder = false
  frequency = "10m"

  settings = {
    addresses   = var.grafana_email_recipients
    uploadImage = "false"
  }
}
