company_name                    = "modernlogic-eks"
environment                     = "dev"
region                          = "us-west-1"
author                          = "arn:aws:iam::600592424179:user/DevopsUser"
app_vpc_cidr                    = "10.205.0.0/16"
initial_database                = "mldefault"
master_db_username              = "us8HJhs6G"
master_db_password              = "9AAWhj4KuQzHe2nPUHe"
kms_grantees                    = ["arn:aws:iam::600592424179:user/nlatourette"]
zone_id                         = "Z073067124R6A5XMNXAVC"
grafana_auth                    = "eyJrIjoidFBBeVJaSE1rVVBKeVVoQWhhNjNabmZzSnh5ZlljcEwiLCJuIjoidGVycmFmb3JtIiwiaWQiOjF9"
snapshot_identifier             = "public-migration-dev"
ecs_alarms_email_recipients     = ["nick@usemodernlogic.com", "matthew@usemodernlogic.com"]
services_to_grant_kms_access_to = ["ses.amazonaws.com"]
create_vpc                      = true

tags = {
  Environment       = "dev"
  Company           = "modernlogic-eks"
  Deployment_Method = "terraform"
}
server_iam_role_policy_statements = [
  {
    effect : "Allow",
    actions = ["ses:SendRawEmail"]
    resources : ["*"]
  },
  {
    effect : "Allow",
    actions : ["ses:Get*", "ses:List*", "ses:Describe*"]
    resources = ["*"]
  },
]
database_security_group_additional_rules = [{
  description = "Dev EC2"
  from_port   = 5432
  to_port     = 5432
  protocol    = "tcp"
  cidr_block  = "54.219.78.85/32"
}]