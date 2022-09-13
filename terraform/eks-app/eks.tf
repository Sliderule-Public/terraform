resource "aws_eks_cluster" "main" {
  count    = var.deploy_eks == true ? 1 : 0
  name     = "${var.environment}-eks"
  version  = ""
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    subnet_ids = local.eks_cluster_subnets_ids
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role.eks,
  ]
}