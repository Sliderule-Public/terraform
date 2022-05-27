provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  host                   = var.endpoint
  cluster_ca_certificate = base64decode(var.certificate_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  version                = "~> 1.9"
}
