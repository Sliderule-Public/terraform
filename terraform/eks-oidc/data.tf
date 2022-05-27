data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_id
}

##################
## IAM Policies ##
##################
data "template_file" "role_trust_relationship" {
  template = file("${path.module}/policies/role_trust_relationship.json.tmpl")
  vars = {
    oidc_arn      = aws_iam_openid_connect_provider.main.arn
    oidc_url      = aws_iam_openid_connect_provider.main.url
    k8s_namespace = var.k8s_namespace
    role_name     = var.role_name
  }
}
