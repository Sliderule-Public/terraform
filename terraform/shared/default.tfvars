zone_dns_name                  = "usemodernlogic.com"
region                         = "us-west-1"
deploy_route53                 = false
company_name                   = "modernlogic"
deploy_ecs_service_linked_role = false
deploy_ecr_repositories        = false
external_aws_account_id        = "600592424179"
external_id                    = "bd2bbf81-4b91-4044-bb11-dc2d3ac6bf45"
ecs_environments_touchable_by_external_account = ["dev", "staging", "sandbox"]