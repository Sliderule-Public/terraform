<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 1.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.15.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 1.13.4 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [kubernetes_service_account.main](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [template_file.role_trust_relationship](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [tls_certificate.main](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy into | `string` | n/a | yes |
| <a name="input_certificate_data"></a> [certificate\_data](#input\_certificate\_data) | certificate data for the ECS cluster. In terraform it can be found at aws\_eks\_cluster.{your\_cluster}.certificate\_authority[0].data | `string` | n/a | yes |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | cluster id of the EKS cluster to use | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | OICD issuer for the EKS cluster, optionally from step 1. In terraform it can be found at aws\_eks\_cluster.{your\_cluster}.endpoint | `string` | n/a | yes |
| <a name="input_issuer"></a> [issuer](#input\_issuer) | OICD issuer for the EKS cluster, optionally from step 1. In terraform it can be found at aws\_eks\_cluster.{your\_cluster}.identity[0].oidc[0].issuer | `string` | n/a | yes |
| <a name="input_k8s_namespace"></a> [k8s\_namespace](#input\_k8s\_namespace) | kubernetes namespace to set the role for. For this stack, it should be the same as the environment passed to eks-app. | `string` | n/a | yes |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | AWS ARN of module.eks\_task\_role from the eks-app stack deployed in step 1 | `string` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of the role made by module.eks\_task\_role from the eks-app stack deployed in step 1 | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->