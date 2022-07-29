resource "aws_iam_role" "eks-tasks" {
  count = var.deploy_eks == true ? 1 : 0
  name  = "${var.company_name}-${var.environment}-eks-tasks"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Effect": "Allow",
      "Principal": {
          "Federated": "${aws_iam_openid_connect_provider.main[0].arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
            "${aws_iam_openid_connect_provider.main[0].url}:sub": "system:serviceaccount:${var.environment}:tasks",
            "${aws_iam_openid_connect_provider.main[0].url}:aud": "sts.amazonaws.com"
        }
      }
    }
  ]
}
POLICY

  inline_policy {
    name   = "eks-alb-${var.environment}"
    policy = data.aws_iam_policy_document.eks_task[0].json
  }
}