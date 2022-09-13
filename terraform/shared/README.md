<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.27 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.27 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_external_role"></a> [external\_role](#module\_external\_role) | ../src/modules/simple/cross_account_iam_role | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.prometheus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_iam_service_linked_role.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cross_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_external_account_read_metrics"></a> [allow\_external\_account\_read\_metrics](#input\_allow\_external\_account\_read\_metrics) | Designates whether the external account can read Cloudwatch metrics | `bool` | `true` | no |
| <a name="input_company_name"></a> [company\_name](#input\_company\_name) | Name of company | `string` | n/a | yes |
| <a name="input_deploy_ecr_repositories"></a> [deploy\_ecr\_repositories](#input\_deploy\_ecr\_repositories) | Option to deploy ECR repositories through this stack. | `bool` | `true` | no |
| <a name="input_deploy_ecs_service_linked_role"></a> [deploy\_ecs\_service\_linked\_role](#input\_deploy\_ecs\_service\_linked\_role) | Boolean, option to deploy a required ECS service-linked role. | `bool` | `true` | no |
| <a name="input_deploy_route53"></a> [deploy\_route53](#input\_deploy\_route53) | Option to deploy a Route53 hosted zone. If this is set to true, also set 'zone\_dns\_name'. | `bool` | `true` | no |
| <a name="input_ecs_environments_touchable_by_external_account"></a> [ecs\_environments\_touchable\_by\_external\_account](#input\_ecs\_environments\_touchable\_by\_external\_account) | The environments that are allowed to be interacted with by the external Sliderule support team | `list(string)` | <pre>[<br>  "dev",<br>  "development",<br>  "staging",<br>  "stage"<br>]</pre> | no |
| <a name="input_external_aws_account_id"></a> [external\_aws\_account\_id](#input\_external\_aws\_account\_id) | AWS account ID for the Sliderule external account | `string` | n/a | yes |
| <a name="input_external_id"></a> [external\_id](#input\_external\_id) | External ID for the external assume role operation | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region that ECS resources will be deployed to | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the service being deployed | `string` | `"shieldrule"` | no |
| <a name="input_zone_dns_name"></a> [zone\_dns\_name](#input\_zone\_dns\_name) | Only needed if you plan to deploy Route 53 resources in this stack. | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->