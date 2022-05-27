company_name       = "modernlogic"
app_name = "shieldrule"
environment        = "sandbox"
region             = "us-west-1"
author             = "arn:aws:iam::600592424179:user/DevopsUser"
app_vpc_cidr       = "10.198.0.0/16"
initial_database   = "mldefault"
master_db_username = "zTQt3zLDQP5ewed7z"
master_db_password = "EMNvXSpkmMVf5axtXMh"
kms_grantees = ["arn:aws:iam::600592424179:user/nlatourette"]
tags = {
  Environment       = "sandbox"
  Company           = "modernlogic"
  Deployment_Method = "terraform"
}
zone_id           = "Z073067124R6A5XMNXAVC"
grafana_auth = "eyJrIjoidFBBeVJaSE1rVVBKeVVoQWhhNjNabmZzSnh5ZlljcEwiLCJuIjoidGVycmFmb3JtIiwiaWQiOjF9"
aws_access_key = "AKIAYXVQZDTZRVIQ3JMI"
aws_secret_key = "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"
grafana_email_recipients = "matthewmartinez1003@gmail.com"
deploy_grafana_resources = true
bastion_ami = "ami-04468e03c37242e1e"
ecs_host_ami = "ami-0615582d093c25b3f"
certificate_arn = "arn:aws:acm:us-west-1:600592424179:certificate/cd85d63c-afc7-4142-ae5b-ac8dde8c7a5e"
domain ="usemodernlogic.com"
api_host_listeners = ["api-sandbox2.usemodernlogic.com"]
docs_host_listeners = ["docs-sandbox.usemodernlogic.com"]
web_host_listeners = ["sandbox.usemodernlogic.com"]
ecs_alarms_email_recipients = ["nick@usemodernlogic.com", "matthew@usemodernlogic.com"]
additional_api_ports = [{
  port: 9520,
  name: "grpc"
  health_check_route: "/"
}]