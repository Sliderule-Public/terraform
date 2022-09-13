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
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_infrastructure_bucket"></a> [infrastructure\_bucket](#module\_infrastructure\_bucket) | ../src/modules/simple/s3_bucket | n/a |
| <a name="module_main_key"></a> [main\_key](#module\_main\_key) | ../src/modules/simple/kms_key | n/a |
| <a name="module_pod_security_group"></a> [pod\_security\_group](#module\_pod\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_rds_instance"></a> [rds\_instance](#module\_rds\_instance) | ../src/modules/simple/rds | n/a |
| <a name="module_rds_key"></a> [rds\_key](#module\_rds\_key) | ../src/modules/simple/kms_key | n/a |
| <a name="module_rds_role"></a> [rds\_role](#module\_rds\_role) | ../src/modules/simple/iam_role | n/a |
| <a name="module_rds_security_group"></a> [rds\_security\_group](#module\_rds\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_redis"></a> [redis](#module\_redis) | ../src/modules/simple/redis | n/a |
| <a name="module_redis_security_group"></a> [redis\_security\_group](#module\_redis\_security\_group) | ../src/modules/simple/vpc_security_group | n/a |
| <a name="module_server_docs_bucket"></a> [server\_docs\_bucket](#module\_server\_docs\_bucket) | ../src/modules/simple/s3_bucket | n/a |
| <a name="module_shared_eks_launch_template"></a> [shared\_eks\_launch\_template](#module\_shared\_eks\_launch\_template) | ../src/modules/simple/launch_template | n/a |
| <a name="module_shared_vpc"></a> [shared\_vpc](#module\_shared\_vpc) | ../src/modules/composite/vpc | n/a |
| <a name="module_sns_key"></a> [sns\_key](#module\_sns\_key) | ../src/modules/simple/kms_key | n/a |
| <a name="module_sqs"></a> [sqs](#module\_sqs) | ../src/modules/simple/sqs_queue | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_openid_connect_provider.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks-alb-controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks-autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks-tasks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_s3_bucket_object.object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [aws_sns_topic.alarms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.ecs_alarms_email_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [null_resource.copy_env_file](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_db_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_generic_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_pod_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_prerequisite_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_redis_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_s3_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.populate_sqs_values](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.prepare_kubernetes_yaml_file](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_ami.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy_document.eks_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.main_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [tls_certificate.main](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarms_email_recipients"></a> [alarms\_email\_recipients](#input\_alarms\_email\_recipients) | list of emails to receive various alarms for this stack | `list(string)` | `[]` | no |
| <a name="input_api_eks_port"></a> [api\_eks\_port](#input\_api\_eks\_port) | used in helm to expose the API service through security group rules | `number` | `31257` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | used to build an SSH key name for the optional EKS node group. | `string` | `"shieldrule"` | no |
| <a name="input_app_vpc_cidr"></a> [app\_vpc\_cidr](#input\_app\_vpc\_cidr) | desired value for the VPC CIDR if create\_vpc is true. If create\_vpc is false, then the CIDR of the VPC being used in vpc\_id. | `string` | n/a | yes |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ARN of the AWS ACM certificate to use with optional EKS-made application load balancers. Only required if var.use\_scripts is true and you're using Sliderule-provided AWS EKS ALB functionality. | `string` | `""` | no |
| <a name="input_company_name"></a> [company\_name](#input\_company\_name) | used in resource naming | `string` | n/a | yes |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | if true, will create a new VPC to host resources in this stack. If false, vpc\_id, private\_subnet\_ids and public\_subnet\_ids are required | `bool` | `true` | no |
| <a name="input_database_instance_type"></a> [database\_instance\_type](#input\_database\_instance\_type) | n/a | `string` | `"db.t3.xlarge"` | no |
| <a name="input_database_security_group_additional_rules"></a> [database\_security\_group\_additional\_rules](#input\_database\_security\_group\_additional\_rules) | optional additional security group rules for the database security group. | <pre>list(object({<br>    description = string<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_block  = string<br>  }))</pre> | `[]` | no |
| <a name="input_deploy_eks"></a> [deploy\_eks](#input\_deploy\_eks) | if true, a new EKS cluster is created | `bool` | `true` | no |
| <a name="input_deploy_read_replica"></a> [deploy\_read\_replica](#input\_deploy\_read\_replica) | if true, deploys an optional read replica for the RDS instance | `bool` | `false` | no |
| <a name="input_docs_eks_port"></a> [docs\_eks\_port](#input\_docs\_eks\_port) | used in helm to expose the docs service through security group rules | `number` | `31256` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | Name of EKS cluster to be used to create OIDC providers for IAM roles. Only required if deploy\_eks is false | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | used in resource naming and namespacing | `string` | n/a | yes |
| <a name="input_iam_arns_to_grant_sns_kms_access_to"></a> [iam\_arns\_to\_grant\_sns\_kms\_access\_to](#input\_iam\_arns\_to\_grant\_sns\_kms\_access\_to) | n/a | `list(string)` | `[]` | no |
| <a name="input_initial_database"></a> [initial\_database](#input\_initial\_database) | name of initial database in RDS | `string` | n/a | yes |
| <a name="input_kms_grantees"></a> [kms\_grantees](#input\_kms\_grantees) | ARNs of IAM users to allow decrypt and encrypt access to KMS keys | `list(string)` | `[]` | no |
| <a name="input_master_db_password"></a> [master\_db\_password](#input\_master\_db\_password) | password to user for master user in RDS | `string` | n/a | yes |
| <a name="input_master_db_username"></a> [master\_db\_username](#input\_master\_db\_username) | master db username to use for RDS | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | only needed if create\_vpc is false. Private subnets to use to host some private resources in this stack | `list(string)` | `[]` | no |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | only needed if create\_vpc is false. Public subnets to use to host some public resources in this stack | `list(string)` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | aws region to deploy into | `string` | n/a | yes |
| <a name="input_server_iam_role_policy_statements"></a> [server\_iam\_role\_policy\_statements](#input\_server\_iam\_role\_policy\_statements) | optional additional IAM policies to apply to the IAM role assigned to the EKS tasks | <pre>list(object({<br>    effect    = string<br>    actions   = list(string)<br>    resources = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_services_to_grant_kms_access_to"></a> [services\_to\_grant\_kms\_access\_to](#input\_services\_to\_grant\_kms\_access\_to) | list of additional AWS services to permit for encrypting / decrypting the KMS keys in this stack | `list(string)` | `[]` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | if true, will skip the final snapshot if the RDS instance is deleted | `bool` | `false` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | optional snapshot to use to create RDS instance | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | optional AWS tags to apply to most resources deployed with this stack | `any` | `{}` | no |
| <a name="input_use_only_private_subnets"></a> [use\_only\_private\_subnets](#input\_use\_only\_private\_subnets) | If true, will use only private subnets to provision all network-dependant resources | `bool` | `false` | no |
| <a name="input_use_variable_scripts"></a> [use\_variable\_scripts](#input\_use\_variable\_scripts) | if true, null\_resource resources will be used to run scripts that generate var files for kubernetes/aws/shieldrule | `bool` | `false` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | only needed if create\_vpc is false. VPC to use to host resources in this stack | `string` | `""` | no |
| <a name="input_web_eks_port"></a> [web\_eks\_port](#input\_web\_eks\_port) | used in helm to expose the web service through security group rules | `number` | `31255` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_EKS_ALB_CONTROLLER_ROLE_ARN"></a> [EKS\_ALB\_CONTROLLER\_ROLE\_ARN](#output\_EKS\_ALB\_CONTROLLER\_ROLE\_ARN) | n/a |
| <a name="output_EKS_TASK_ROLE_ARN"></a> [EKS\_TASK\_ROLE\_ARN](#output\_EKS\_TASK\_ROLE\_ARN) | n/a |
| <a name="output_ENVIRONMENT"></a> [ENVIRONMENT](#output\_ENVIRONMENT) | n/a |
| <a name="output_POSTGRES_HOST"></a> [POSTGRES\_HOST](#output\_POSTGRES\_HOST) | n/a |
| <a name="output_POSTGRES_PORT"></a> [POSTGRES\_PORT](#output\_POSTGRES\_PORT) | n/a |
| <a name="output_REDIS_HOST"></a> [REDIS\_HOST](#output\_REDIS\_HOST) | n/a |
| <a name="output_REDIS_PORT"></a> [REDIS\_PORT](#output\_REDIS\_PORT) | n/a |
| <a name="output_SENTRY_ENVIRONMENT"></a> [SENTRY\_ENVIRONMENT](#output\_SENTRY\_ENVIRONMENT) | n/a |
| <a name="output_SERVER_BUCKET"></a> [SERVER\_BUCKET](#output\_SERVER\_BUCKET) | n/a |
| <a name="output_SHIELDRULE_ENVIRONMENT"></a> [SHIELDRULE\_ENVIRONMENT](#output\_SHIELDRULE\_ENVIRONMENT) | n/a |
| <a name="output_SQS_QUEUE_NAME"></a> [SQS\_QUEUE\_NAME](#output\_SQS\_QUEUE\_NAME) | n/a |
| <a name="output_SQS_URL"></a> [SQS\_URL](#output\_SQS\_URL) | n/a |
<!-- END_TF_DOCS -->