company_name       = "modernlogic"
app_name = "shieldrule"
environment        = "dev"
region             = "us-west-1"
author             = "arn:aws:iam::600592424179:user/DevopsUser"
app_vpc_cidr       = "10.199.0.0/16"
initial_database   = "mldefault"
master_db_username = "us8HJhs6G"
master_db_password = "9AAWhj4KuQzHe2nPUHe"
kms_grantees = ["arn:aws:iam::600592424179:user/nlatourette"]
tags = {
  Environment       = "dev"
  Company           = "modernlogic"
  Deployment_Method = "terraform"
}
zone_id           = "Z073067124R6A5XMNXAVC"
grafana_auth = "eyJrIjoidFBBeVJaSE1rVVBKeVVoQWhhNjNabmZzSnh5ZlljcEwiLCJuIjoidGVycmFmb3JtIiwiaWQiOjF9"
aws_access_key = "AKIAYXVQZDTZRVIQ3JMI"
aws_secret_key = "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"
grafana_email_recipients = ""
snapshot_identifier = "public-migration-dev"
deploy_grafana_resources = true
bastion_ami = "ami-04468e03c37242e1e"
ecs_host_ami = "ami-0615582d093c25b3f"
certificate_arn = "arn:aws:acm:us-west-1:600592424179:certificate/cd85d63c-afc7-4142-ae5b-ac8dde8c7a5e"
domain ="usemodernlogic.com"
//api_host_listeners = ["api-dev.usemodernlogic.com"]
//docs_host_listeners = ["docs-dev.usemodernlogic.com"]
//web_host_listeners = ["dev.usemodernlogic.com"]
ecs_alarms_email_recipients = ["nick@usemodernlogic.com", "matthew@usemodernlogic.com"]
server_iam_role_policy_statements = [
  {
  effect: "Allow",
  actions = ["ses:SendRawEmail"]
  resources: ["*"]
  },
  {
    effect: "Allow",
    actions: ["ses:Get*", "ses:List*", "ses:Describe*"]
    resources = ["*"]
  },
]
database_security_group_additional_rules = [{
  description = "Dev EC2"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  cidr_block = "54.219.78.85/32"
}]

services_to_grant_kms_access_to = ["ses.amazonaws.com"]
auth0_password = "s9d7hc8ysb6TTY"
auth0_domain = "usemodernlogic.us.auth0.com"
auth0_client_id = "RvE6QDOJqKZy6roVu24ki6HxTuP17nqD"
auth0_secret = "GBOaP0D6NysoA5Tutmyq2DmGcppxPhNW9TMPKRxifChzuK1DQSL7IlikVkVgoTiQ"