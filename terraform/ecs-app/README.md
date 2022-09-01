## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.27 |
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | ~> 1.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.75.2 |
| <a name="provider_grafana"></a> [grafana](#provider\_grafana) | 1.12.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_ecs_service"></a> [api\_ecs\_service](#module\_api\_ecs\_service) | ../src/modules/simple/ecs_service_api | n/a |
| <a name="module_api_route53_record"></a> [api\_route53\_record](#module\_api\_route53\_record) | ../src/modules/simple/route53_record | n/a |
| <a name="module_api_task_definition"></a> [api\_task\_definition](#module\_api\_task\_definition) | ../src/modules/simple/ecs_service_task_definition_api | n/a |
| <a name="module_bastion_host_ssm_policy_attachment"></a> [bastion\_host\_ssm\_policy\_attachment](#module\_bastion\_host\_ssm\_policy\_attachment) | ../src/modules/simple/iam_role_policy_attachment | n/a |
| <a name="module_bastion_instance_profile"></a> [bastion\_instance\_profile](#module\_bastion\_instance\_profile) | ../src/modules/simple/instance_profile | n/a |
| <a name="module_bastion_role"></a> [bastion\_role](#module\_bastion\_role) | ../src/modules/simple/iam_role | n/a |
| <a name="module_database_access_security_group"></a> [database\_access\_security\_group](#module\_database\_access\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_ecs_host_role"></a> [ecs\_host\_role](#module\_ecs\_host\_role) | ../src/modules/simple/iam_role | n/a |
| <a name="module_ecs_host_ssm_policy_attachment"></a> [ecs\_host\_ssm\_policy\_attachment](#module\_ecs\_host\_ssm\_policy\_attachment) | ../src/modules/simple/iam_role_policy_attachment | n/a |
| <a name="module_ecs_shared_instance_profile"></a> [ecs\_shared\_instance\_profile](#module\_ecs\_shared\_instance\_profile) | ../src/modules/simple/instance_profile | n/a |
| <a name="module_ecs_task_execution_role"></a> [ecs\_task\_execution\_role](#module\_ecs\_task\_execution\_role) | ../src/modules/simple/iam_role | n/a |
| <a name="module_ecs_task_role"></a> [ecs\_task\_role](#module\_ecs\_task\_role) | ../src/modules/simple/iam_role | n/a |
| <a name="module_grpc_record"></a> [grpc\_record](#module\_grpc\_record) | ../src/modules/simple/route53_record | n/a |
| <a name="module_infrastructure_bucket"></a> [infrastructure\_bucket](#module\_infrastructure\_bucket) | ../src/modules/simple/s3_bucket | n/a |
| <a name="module_main_key"></a> [main\_key](#module\_main\_key) | ../src/modules/simple/kms_key | n/a |
| <a name="module_prometheus_role"></a> [prometheus\_role](#module\_prometheus\_role) | ../src/modules/simple/iam_role | n/a |
| <a name="module_rds_instance"></a> [rds\_instance](#module\_rds\_instance) | ../src/modules/simple/rds | n/a |
| <a name="module_rds_key"></a> [rds\_key](#module\_rds\_key) | ../src/modules/simple/kms_key | n/a |
| <a name="module_rds_role"></a> [rds\_role](#module\_rds\_role) | ../src/modules/simple/iam_role | n/a |
| <a name="module_rds_security_group"></a> [rds\_security\_group](#module\_rds\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_redis"></a> [redis](#module\_redis) | ../src/modules/simple/redis | n/a |
| <a name="module_redis_security_group"></a> [redis\_security\_group](#module\_redis\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_server_docs_bucket"></a> [server\_docs\_bucket](#module\_server\_docs\_bucket) | ../src/modules/simple/s3_bucket | n/a |
| <a name="module_services_ecs_cluster"></a> [services\_ecs\_cluster](#module\_services\_ecs\_cluster) | ../src/modules/simple/ecs_cluster | n/a |
| <a name="module_shared_bastion_auto_scaling_group"></a> [shared\_bastion\_auto\_scaling\_group](#module\_shared\_bastion\_auto\_scaling\_group) | ../src/modules/simple/auto_scaling_group | n/a |
| <a name="module_shared_bastion_launch_template"></a> [shared\_bastion\_launch\_template](#module\_shared\_bastion\_launch\_template) | ../src/modules/simple/launch_template | n/a |
| <a name="module_shared_bastion_security_group"></a> [shared\_bastion\_security\_group](#module\_shared\_bastion\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_shared_ecs_auto_scaling_group"></a> [shared\_ecs\_auto\_scaling\_group](#module\_shared\_ecs\_auto\_scaling\_group) | ../src/modules/simple/auto_scaling_group | n/a |
| <a name="module_shared_ecs_launch_template"></a> [shared\_ecs\_launch\_template](#module\_shared\_ecs\_launch\_template) | ../src/modules/simple/launch_template | n/a |
| <a name="module_shared_ecs_load_balancer"></a> [shared\_ecs\_load\_balancer](#module\_shared\_ecs\_load\_balancer) | ../src/modules/simple/load_balancer | n/a |
| <a name="module_shared_ecs_service_security_group"></a> [shared\_ecs\_service\_security\_group](#module\_shared\_ecs\_service\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_shared_launch_template_security_group"></a> [shared\_launch\_template\_security\_group](#module\_shared\_launch\_template\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_shared_load_balancer_security_group"></a> [shared\_load\_balancer\_security\_group](#module\_shared\_load\_balancer\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_shared_vpc"></a> [shared\_vpc](#module\_shared\_vpc) | ../src/modules/composite/vpc | n/a |
| <a name="module_sqs"></a> [sqs](#module\_sqs) | ../src/modules/simple/sqs_queue | n/a |
| <a name="module_web_ecs_service"></a> [web\_ecs\_service](#module\_web\_ecs\_service) | ../src/modules/simple/ecs_service | n/a |
| <a name="module_web_route53_record"></a> [web\_route53\_record](#module\_web\_route53\_record) | ../src/modules/simple/route53_record | n/a |
| <a name="module_web_task_definition"></a> [web\_task\_definition](#module\_web\_task\_definition) | ../src/modules/simple/ecs_service_task_definition | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_lb_listener_rule.redirects](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_s3_bucket_object.object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [aws_sns_topic.alarms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.ecs_alarms_email_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_ssm_parameter.private_subnet_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.private_subnet_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.redis_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.sqs_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [grafana_alert_notification.email](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/alert_notification) | resource |
| [grafana_dashboard.metrics_api](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/dashboard) | resource |
| [grafana_dashboard.metrics_docs](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/dashboard) | resource |
| [grafana_dashboard.metrics_web](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/dashboard) | resource |
| [grafana_dashboard.redis](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/dashboard) | resource |
| [grafana_dashboard.sqs](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/dashboard) | resource |
| [grafana_data_source.cloudwatch](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/data_source) | resource |
| [null_resource.copy_env_file](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.create_auth0_user](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_db_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_generic_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_redis_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_s3_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_sqs_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_ami.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.main_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.ecs_domain_names](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_route53_zone.extra_domain_names](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_health_check_interval"></a> [api\_health\_check\_interval](#input\_api\_health\_check\_interval) | n/a | `number` | `60` | no |
| <a name="input_api_health_check_timeout"></a> [api\_health\_check\_timeout](#input\_api\_health\_check\_timeout) | n/a | `number` | `10` | no |
| <a name="input_api_healthy_threshold"></a> [api\_healthy\_threshold](#input\_api\_healthy\_threshold) | n/a | `number` | `2` | no |
| <a name="input_api_subdomains"></a> [api\_subdomains](#input\_api\_subdomains) | n/a | `list(string)` | n/a | yes |
| <a name="input_api_task_memory"></a> [api\_task\_memory](#input\_api\_task\_memory) | n/a | `number` | `31000` | no |
| <a name="input_api_task_vcpu"></a> [api\_task\_vcpu](#input\_api\_task\_vcpu) | n/a | `number` | `7800` | no |
| <a name="input_api_unhealthy_threshold"></a> [api\_unhealthy\_threshold](#input\_api\_unhealthy\_threshold) | n/a | `number` | `2` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | n/a | `string` | n/a | yes |
| <a name="input_app_vpc_cidr"></a> [app\_vpc\_cidr](#input\_app\_vpc\_cidr) | n/a | `string` | n/a | yes |
| <a name="input_auth0_client_id"></a> [auth0\_client\_id](#input\_auth0\_client\_id) | n/a | `string` | n/a | yes |
| <a name="input_auth0_domain"></a> [auth0\_domain](#input\_auth0\_domain) | n/a | `string` | n/a | yes |
| <a name="input_auth0_password"></a> [auth0\_password](#input\_auth0\_password) | Password for the auth0 user in the postgresql database | `string` | n/a | yes |
| <a name="input_auth0_secret"></a> [auth0\_secret](#input\_auth0\_secret) | n/a | `string` | n/a | yes |
| <a name="input_author"></a> [author](#input\_author) | n/a | `string` | n/a | yes |
| <a name="input_aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | n/a | `string` | n/a | yes |
| <a name="input_aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | n/a | `string` | n/a | yes |
| <a name="input_bastion_ami"></a> [bastion\_ami](#input\_bastion\_ami) | n/a | `string` | `""` | no |
| <a name="input_bastion_instance_type"></a> [bastion\_instance\_type](#input\_bastion\_instance\_type) | n/a | `string` | `"t3.small"` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | n/a | `string` | n/a | yes |
| <a name="input_company_name"></a> [company\_name](#input\_company\_name) | n/a | `string` | n/a | yes |
| <a name="input_database_instance_type"></a> [database\_instance\_type](#input\_database\_instance\_type) | n/a | `string` | `"db.t2.large"` | no |
| <a name="input_database_security_group_additional_rules"></a> [database\_security\_group\_additional\_rules](#input\_database\_security\_group\_additional\_rules) | n/a | <pre>list(object({<br>    description = string<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_block  = string<br>  }))</pre> | `[]` | no |
| <a name="input_deploy_grafana_resources"></a> [deploy\_grafana\_resources](#input\_deploy\_grafana\_resources) | n/a | `bool` | `"false"` | no |
| <a name="input_deploy_route53_resources"></a> [deploy\_route53\_resources](#input\_deploy\_route53\_resources) | n/a | `bool` | `true` | no |
| <a name="input_desired_task_count_api"></a> [desired\_task\_count\_api](#input\_desired\_task\_count\_api) | n/a | `number` | `3` | no |
| <a name="input_desired_task_count_web"></a> [desired\_task\_count\_web](#input\_desired\_task\_count\_web) | n/a | `number` | `2` | no |
| <a name="input_domains_to_redirect"></a> [domains\_to\_redirect](#input\_domains\_to\_redirect) | n/a | <pre>list(object({<br>    from = string<br>    to   = string<br>  }))</pre> | `[]` | no |
| <a name="input_ecs_alarms_email_recipients"></a> [ecs\_alarms\_email\_recipients](#input\_ecs\_alarms\_email\_recipients) | n/a | `list(string)` | `[]` | no |
| <a name="input_ecs_domain_names"></a> [ecs\_domain\_names](#input\_ecs\_domain\_names) | Domain names, which when combined with var.web\_subdomains and var.api\_subdomains, create the domains that your ECS services will listen on. If var.deploy\_route53\_resources is set to true, subdomains will also be created in the Route 53 hosted zones for these domain names. | `list(string)` | n/a | yes |
| <a name="input_ecs_host_ami"></a> [ecs\_host\_ami](#input\_ecs\_host\_ami) | n/a | `string` | `""` | no |
| <a name="input_elb_idle_timeout"></a> [elb\_idle\_timeout](#input\_elb\_idle\_timeout) | n/a | `number` | `60` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_extra_domain_names"></a> [extra\_domain\_names](#input\_extra\_domain\_names) | If var.deploy\_route53\_resources is set to true, subdomains will be created in the Route 53 hosted zones for these optional extra domain names. This is only offered to create extra Route 53 entries and can be left empty at any time. | `list(string)` | `[]` | no |
| <a name="input_grafana_auth"></a> [grafana\_auth](#input\_grafana\_auth) | n/a | `string` | `""` | no |
| <a name="input_grafana_email_recipients"></a> [grafana\_email\_recipients](#input\_grafana\_email\_recipients) | n/a | `string` | `""` | no |
| <a name="input_host_instance_type"></a> [host\_instance\_type](#input\_host\_instance\_type) | n/a | `string` | `"t3.xlarge"` | no |
| <a name="input_initial_database"></a> [initial\_database](#input\_initial\_database) | n/a | `string` | n/a | yes |
| <a name="input_kms_grantees"></a> [kms\_grantees](#input\_kms\_grantees) | n/a | `list(string)` | n/a | yes |
| <a name="input_master_db_password"></a> [master\_db\_password](#input\_master\_db\_password) | n/a | `string` | n/a | yes |
| <a name="input_master_db_username"></a> [master\_db\_username](#input\_master\_db\_username) | n/a | `string` | n/a | yes |
| <a name="input_maximum_host_count"></a> [maximum\_host\_count](#input\_maximum\_host\_count) | n/a | `number` | `10` | no |
| <a name="input_minimum_host_count"></a> [minimum\_host\_count](#input\_minimum\_host\_count) | n/a | `number` | `1` | no |
| <a name="input_redis_node_type"></a> [redis\_node\_type](#input\_redis\_node\_type) | n/a | `string` | `"cache.m4.xlarge"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_server_iam_role_policy_statements"></a> [server\_iam\_role\_policy\_statements](#input\_server\_iam\_role\_policy\_statements) | n/a | <pre>list(object({<br>    effect    = string<br>    actions   = list(string)<br>    resources = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_services_to_grant_kms_access_to"></a> [services\_to\_grant\_kms\_access\_to](#input\_services\_to\_grant\_kms\_access\_to) | n/a | `list(string)` | `[]` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | n/a | `bool` | `false` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | n/a | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | <pre>object({<br>    Environment       = string<br>    Company           = string<br>    Deployment_Method = string<br>  })</pre> | n/a | yes |
| <a name="input_use_variable_scripts"></a> [use\_variable\_scripts](#input\_use\_variable\_scripts) | if true, null\_resource resources will be used to run scripts that generate var files for kubernetes/aws/shieldrule | `bool` | `false` | no |
| <a name="input_web_subdomains"></a> [web\_subdomains](#input\_web\_subdomains) | n/a | `list(string)` | n/a | yes |

## Outputs

No outputs.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.27 |
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | ~> 1.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.75.2 |
| <a name="provider_grafana"></a> [grafana](#provider\_grafana) | 1.12.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_ecs_service"></a> [api\_ecs\_service](#module\_api\_ecs\_service) | ../src/modules/simple/ecs_service_api | n/a |
| <a name="module_api_route53_record"></a> [api\_route53\_record](#module\_api\_route53\_record) | ../src/modules/simple/route53_record | n/a |
| <a name="module_api_task_definition"></a> [api\_task\_definition](#module\_api\_task\_definition) | ../src/modules/simple/ecs_service_task_definition_api | n/a |
| <a name="module_bastion_host_ssm_policy_attachment"></a> [bastion\_host\_ssm\_policy\_attachment](#module\_bastion\_host\_ssm\_policy\_attachment) | ../src/modules/simple/iam_role_policy_attachment | n/a |
| <a name="module_bastion_instance_profile"></a> [bastion\_instance\_profile](#module\_bastion\_instance\_profile) | ../src/modules/simple/instance_profile | n/a |
| <a name="module_bastion_role"></a> [bastion\_role](#module\_bastion\_role) | ../src/modules/simple/iam_role | n/a |
| <a name="module_database_access_security_group"></a> [database\_access\_security\_group](#module\_database\_access\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_ecs_host_role"></a> [ecs\_host\_role](#module\_ecs\_host\_role) | ../src/modules/simple/iam_role | n/a |
| <a name="module_ecs_host_ssm_policy_attachment"></a> [ecs\_host\_ssm\_policy\_attachment](#module\_ecs\_host\_ssm\_policy\_attachment) | ../src/modules/simple/iam_role_policy_attachment | n/a |
| <a name="module_ecs_shared_instance_profile"></a> [ecs\_shared\_instance\_profile](#module\_ecs\_shared\_instance\_profile) | ../src/modules/simple/instance_profile | n/a |
| <a name="module_ecs_task_execution_role"></a> [ecs\_task\_execution\_role](#module\_ecs\_task\_execution\_role) | ../src/modules/simple/iam_role | n/a |
| <a name="module_ecs_task_role"></a> [ecs\_task\_role](#module\_ecs\_task\_role) | ../src/modules/simple/iam_role | n/a |
| <a name="module_grpc_record"></a> [grpc\_record](#module\_grpc\_record) | ../src/modules/simple/route53_record | n/a |
| <a name="module_infrastructure_bucket"></a> [infrastructure\_bucket](#module\_infrastructure\_bucket) | ../src/modules/simple/s3_bucket | n/a |
| <a name="module_jobs_ecs_service"></a> [jobs\_ecs\_service](#module\_jobs\_ecs\_service) | ../src/modules/simple/ecs_service_no_route | n/a |
| <a name="module_jobs_task_definition"></a> [jobs\_task\_definition](#module\_jobs\_task\_definition) | ../src/modules/simple/ecs_service_task_definition | n/a |
| <a name="module_main_key"></a> [main\_key](#module\_main\_key) | ../src/modules/simple/kms_key | n/a |
| <a name="module_pod_security_group"></a> [pod\_security\_group](#module\_pod\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_prometheus_role"></a> [prometheus\_role](#module\_prometheus\_role) | ../src/modules/simple/iam_role | n/a |
| <a name="module_rds_instance"></a> [rds\_instance](#module\_rds\_instance) | ../src/modules/simple/rds | n/a |
| <a name="module_rds_key"></a> [rds\_key](#module\_rds\_key) | ../src/modules/simple/kms_key | n/a |
| <a name="module_rds_role"></a> [rds\_role](#module\_rds\_role) | ../src/modules/simple/iam_role | n/a |
| <a name="module_rds_security_group"></a> [rds\_security\_group](#module\_rds\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_redis"></a> [redis](#module\_redis) | ../src/modules/simple/redis | n/a |
| <a name="module_redis_security_group"></a> [redis\_security\_group](#module\_redis\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_server_docs_bucket"></a> [server\_docs\_bucket](#module\_server\_docs\_bucket) | ../src/modules/simple/s3_bucket | n/a |
| <a name="module_services_ecs_cluster"></a> [services\_ecs\_cluster](#module\_services\_ecs\_cluster) | ../src/modules/simple/ecs_cluster | n/a |
| <a name="module_shared_bastion_auto_scaling_group"></a> [shared\_bastion\_auto\_scaling\_group](#module\_shared\_bastion\_auto\_scaling\_group) | ../src/modules/simple/auto_scaling_group | n/a |
| <a name="module_shared_bastion_launch_template"></a> [shared\_bastion\_launch\_template](#module\_shared\_bastion\_launch\_template) | ../src/modules/simple/launch_template | n/a |
| <a name="module_shared_bastion_security_group"></a> [shared\_bastion\_security\_group](#module\_shared\_bastion\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_shared_ecs_auto_scaling_group"></a> [shared\_ecs\_auto\_scaling\_group](#module\_shared\_ecs\_auto\_scaling\_group) | ../src/modules/simple/auto_scaling_group | n/a |
| <a name="module_shared_ecs_launch_template"></a> [shared\_ecs\_launch\_template](#module\_shared\_ecs\_launch\_template) | ../src/modules/simple/launch_template | n/a |
| <a name="module_shared_ecs_load_balancer"></a> [shared\_ecs\_load\_balancer](#module\_shared\_ecs\_load\_balancer) | ../src/modules/simple/load_balancer | n/a |
| <a name="module_shared_ecs_service_security_group"></a> [shared\_ecs\_service\_security\_group](#module\_shared\_ecs\_service\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_shared_eks_launch_template"></a> [shared\_eks\_launch\_template](#module\_shared\_eks\_launch\_template) | ../src/modules/simple/launch_template | n/a |
| <a name="module_shared_launch_template_security_group"></a> [shared\_launch\_template\_security\_group](#module\_shared\_launch\_template\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_shared_load_balancer_security_group"></a> [shared\_load\_balancer\_security\_group](#module\_shared\_load\_balancer\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_shared_vpc"></a> [shared\_vpc](#module\_shared\_vpc) | ../src/modules/composite/vpc | n/a |
| <a name="module_sns_key"></a> [sns\_key](#module\_sns\_key) | ../src/modules/simple/kms_key | n/a |
| <a name="module_sqs"></a> [sqs](#module\_sqs) | ../src/modules/simple/sqs_queue | n/a |
| <a name="module_web_ecs_service"></a> [web\_ecs\_service](#module\_web\_ecs\_service) | ../src/modules/simple/ecs_service | n/a |
| <a name="module_web_route53_record"></a> [web\_route53\_record](#module\_web\_route53\_record) | ../src/modules/simple/route53_record | n/a |
| <a name="module_web_task_definition"></a> [web\_task\_definition](#module\_web\_task\_definition) | ../src/modules/simple/ecs_service_task_definition | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_eks_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_openid_connect_provider.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks-alb-controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks-autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks-tasks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lb_listener_rule.redirects](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_s3_bucket_object.object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [aws_sns_topic.alarms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.ecs_alarms_email_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_ssm_parameter.private_subnet_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.private_subnet_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.redis_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.sqs_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [grafana_alert_notification.email](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/alert_notification) | resource |
| [grafana_dashboard.metrics_api](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/dashboard) | resource |
| [grafana_dashboard.metrics_docs](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/dashboard) | resource |
| [grafana_dashboard.metrics_web](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/dashboard) | resource |
| [grafana_dashboard.redis](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/dashboard) | resource |
| [grafana_dashboard.sqs](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/dashboard) | resource |
| [grafana_data_source.cloudwatch](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/data_source) | resource |
| [null_resource.copy_env_file](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.create_auth0_user](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_db_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_generic_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_pod_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_prerequisite_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_redis_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_s3_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_sqs_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.prepare_kubernetes_yaml_file](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_ami.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.eks_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.main_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.ecs_domain_names](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_route53_zone.extra_domain_names](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [tls_certificate.main](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_eks_port"></a> [api\_eks\_port](#input\_api\_eks\_port) | optional. used in helm to expose the API service through security group rules | `number` | `31257` | no |
| <a name="input_api_health_check_interval"></a> [api\_health\_check\_interval](#input\_api\_health\_check\_interval) | n/a | `number` | `60` | no |
| <a name="input_api_health_check_timeout"></a> [api\_health\_check\_timeout](#input\_api\_health\_check\_timeout) | n/a | `number` | `10` | no |
| <a name="input_api_healthy_threshold"></a> [api\_healthy\_threshold](#input\_api\_healthy\_threshold) | n/a | `number` | `2` | no |
| <a name="input_api_subdomains"></a> [api\_subdomains](#input\_api\_subdomains) | n/a | `list(string)` | n/a | yes |
| <a name="input_api_task_memory"></a> [api\_task\_memory](#input\_api\_task\_memory) | n/a | `number` | `31000` | no |
| <a name="input_api_task_vcpu"></a> [api\_task\_vcpu](#input\_api\_task\_vcpu) | n/a | `number` | `7800` | no |
| <a name="input_api_unhealthy_threshold"></a> [api\_unhealthy\_threshold](#input\_api\_unhealthy\_threshold) | n/a | `number` | `2` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | n/a | `string` | n/a | yes |
| <a name="input_app_vpc_cidr"></a> [app\_vpc\_cidr](#input\_app\_vpc\_cidr) | n/a | `string` | n/a | yes |
| <a name="input_auth0_client_id"></a> [auth0\_client\_id](#input\_auth0\_client\_id) | n/a | `string` | n/a | yes |
| <a name="input_auth0_domain"></a> [auth0\_domain](#input\_auth0\_domain) | n/a | `string` | n/a | yes |
| <a name="input_auth0_password"></a> [auth0\_password](#input\_auth0\_password) | Password for the auth0 user in the postgresql database | `string` | n/a | yes |
| <a name="input_auth0_secret"></a> [auth0\_secret](#input\_auth0\_secret) | n/a | `string` | n/a | yes |
| <a name="input_author"></a> [author](#input\_author) | n/a | `string` | n/a | yes |
| <a name="input_aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | n/a | `string` | n/a | yes |
| <a name="input_aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | n/a | `string` | n/a | yes |
| <a name="input_bastion_ami"></a> [bastion\_ami](#input\_bastion\_ami) | n/a | `string` | `""` | no |
| <a name="input_bastion_instance_type"></a> [bastion\_instance\_type](#input\_bastion\_instance\_type) | n/a | `string` | `"t3.small"` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | n/a | `string` | n/a | yes |
| <a name="input_company_name"></a> [company\_name](#input\_company\_name) | n/a | `string` | n/a | yes |
| <a name="input_database_instance_type"></a> [database\_instance\_type](#input\_database\_instance\_type) | n/a | `string` | `"db.t3.xlarge"` | no |
| <a name="input_database_security_group_additional_rules"></a> [database\_security\_group\_additional\_rules](#input\_database\_security\_group\_additional\_rules) | n/a | <pre>list(object({<br>    description = string<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_block  = string<br>  }))</pre> | `[]` | no |
| <a name="input_deploy_ecs"></a> [deploy\_ecs](#input\_deploy\_ecs) | if true, a new ECS cluster and surrounding resources are created | `bool` | `true` | no |
| <a name="input_deploy_eks"></a> [deploy\_eks](#input\_deploy\_eks) | if true, a new EKS cluster and surrounding resources are created | `bool` | `false` | no |
| <a name="input_deploy_grafana_resources"></a> [deploy\_grafana\_resources](#input\_deploy\_grafana\_resources) | n/a | `bool` | `"false"` | no |
| <a name="input_deploy_read_replica"></a> [deploy\_read\_replica](#input\_deploy\_read\_replica) | Whether to add a read replica | `bool` | `false` | no |
| <a name="input_deploy_route53_resources"></a> [deploy\_route53\_resources](#input\_deploy\_route53\_resources) | n/a | `bool` | `true` | no |
| <a name="input_desired_task_count_api"></a> [desired\_task\_count\_api](#input\_desired\_task\_count\_api) | n/a | `number` | `3` | no |
| <a name="input_desired_task_count_web"></a> [desired\_task\_count\_web](#input\_desired\_task\_count\_web) | n/a | `number` | `2` | no |
| <a name="input_docs_eks_port"></a> [docs\_eks\_port](#input\_docs\_eks\_port) | optional. used in helm to expose the docs service through security group rules | `number` | `31256` | no |
| <a name="input_domains_to_redirect"></a> [domains\_to\_redirect](#input\_domains\_to\_redirect) | n/a | <pre>list(object({<br>    from = string<br>    to   = string<br>  }))</pre> | `[]` | no |
| <a name="input_ecs_alarms_email_recipients"></a> [ecs\_alarms\_email\_recipients](#input\_ecs\_alarms\_email\_recipients) | n/a | `list(string)` | `[]` | no |
| <a name="input_ecs_domain_names"></a> [ecs\_domain\_names](#input\_ecs\_domain\_names) | Domain names, which when combined with var.web\_subdomains and var.api\_subdomains, create the domains that your ECS services will listen on. If var.deploy\_route53\_resources is set to true, subdomains will also be created in the Route 53 hosted zones for these domain names. | `list(string)` | n/a | yes |
| <a name="input_ecs_host_ami"></a> [ecs\_host\_ami](#input\_ecs\_host\_ami) | n/a | `string` | `""` | no |
| <a name="input_elb_idle_timeout"></a> [elb\_idle\_timeout](#input\_elb\_idle\_timeout) | n/a | `number` | `60` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_extra_domain_names"></a> [extra\_domain\_names](#input\_extra\_domain\_names) | If var.deploy\_route53\_resources is set to true, subdomains will be created in the Route 53 hosted zones for these optional extra domain names. This is only offered to create extra Route 53 entries and can be left empty at any time. | `list(string)` | `[]` | no |
| <a name="input_grafana_auth"></a> [grafana\_auth](#input\_grafana\_auth) | n/a | `string` | `""` | no |
| <a name="input_grafana_email_recipients"></a> [grafana\_email\_recipients](#input\_grafana\_email\_recipients) | n/a | `string` | `""` | no |
| <a name="input_host_instance_type"></a> [host\_instance\_type](#input\_host\_instance\_type) | n/a | `string` | `"t3.xlarge"` | no |
| <a name="input_iam_arns_to_grant_sns_kms_access_to"></a> [iam\_arns\_to\_grant\_sns\_kms\_access\_to](#input\_iam\_arns\_to\_grant\_sns\_kms\_access\_to) | n/a | `list(string)` | `[]` | no |
| <a name="input_initial_database"></a> [initial\_database](#input\_initial\_database) | n/a | `string` | n/a | yes |
| <a name="input_kms_grantees"></a> [kms\_grantees](#input\_kms\_grantees) | n/a | `list(string)` | n/a | yes |
| <a name="input_master_db_password"></a> [master\_db\_password](#input\_master\_db\_password) | n/a | `string` | n/a | yes |
| <a name="input_master_db_username"></a> [master\_db\_username](#input\_master\_db\_username) | n/a | `string` | n/a | yes |
| <a name="input_maximum_host_count"></a> [maximum\_host\_count](#input\_maximum\_host\_count) | n/a | `number` | `10` | no |
| <a name="input_minimum_host_count"></a> [minimum\_host\_count](#input\_minimum\_host\_count) | n/a | `number` | `1` | no |
| <a name="input_redis_node_type"></a> [redis\_node\_type](#input\_redis\_node\_type) | n/a | `string` | `"cache.m4.xlarge"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_server_iam_role_policy_statements"></a> [server\_iam\_role\_policy\_statements](#input\_server\_iam\_role\_policy\_statements) | n/a | <pre>list(object({<br>    effect    = string<br>    actions   = list(string)<br>    resources = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_services_to_grant_kms_access_to"></a> [services\_to\_grant\_kms\_access\_to](#input\_services\_to\_grant\_kms\_access\_to) | n/a | `list(string)` | `[]` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | n/a | `bool` | `false` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | n/a | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | <pre>object({<br>    Environment       = string<br>    Company           = string<br>    Deployment_Method = string<br>  })</pre> | n/a | yes |
| <a name="input_upload_env_file"></a> [upload\_env\_file](#input\_upload\_env\_file) | if true, an env file is uploaded automatically to S3 for use with ECS API containers | `bool` | `false` | no |
| <a name="input_use_variable_scripts"></a> [use\_variable\_scripts](#input\_use\_variable\_scripts) | if true, null\_resource resources will be used to run scripts that generate var files for kubernetes/aws/shieldrule | `bool` | `false` | no |
| <a name="input_web_eks_port"></a> [web\_eks\_port](#input\_web\_eks\_port) | optional. used in helm to expose the web service through security group rules | `number` | `31255` | no |
| <a name="input_web_subdomains"></a> [web\_subdomains](#input\_web\_subdomains) | n/a | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->