resource "aws_eks_cluster" "main" {
  count    = var.deploy_eks == true ? 1 : 0
  name     = "${var.environment}-eks"
  version  = ""
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    subnet_ids = local.public_subnet_ids
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role.eks,
  ]
}

resource "aws_eks_node_group" "main" {
  count           = var.deploy_eks == true ? 1 : 0
  cluster_name    = aws_eks_cluster.main[0].name
  node_group_name = "${var.environment}-eks"
  node_role_arn   = aws_iam_role.eks.arn
  subnet_ids      = local.public_subnet_ids
  instance_types  = ["t3.2xlarge"]

  scaling_config {
    desired_size = 1
    max_size     = 5
    min_size     = 1
  }

  update_config {
    max_unavailable = 2
  }

  depends_on = [
    aws_eks_cluster.main
  ]
}