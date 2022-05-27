####################
## OpenID Connect ##
####################
data "tls_certificate" "main" {
  url = var.issuer
}

resource "aws_iam_openid_connect_provider" "main" {
  url = var.issuer

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [
    data.tls_certificate.main.certificates.0.sha1_fingerprint
  ]
}

############
## K8s SA ##
############
resource "kubernetes_service_account" "main" {
  metadata {
    name      = var.role_name
    namespace = var.k8s_namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = var.role_arn
    }
  }
  automount_service_account_token = true
}
