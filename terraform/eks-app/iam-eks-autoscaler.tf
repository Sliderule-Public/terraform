resource "aws_iam_role" "eks-autoscaler" {
  count = var.deploy_eks == true ? 1 : 0
  name  = "${var.company_name}-${var.environment}-eks-autoscaler"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
          "Federated": "${aws_iam_openid_connect_provider.main.arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
            "${aws_iam_openid_connect_provider.main.url}:sub": "system:serviceaccount:kube-system:cluster-autoscaler",
            "${aws_iam_openid_connect_provider.main.url}:aud": "sts.amazonaws.com"
        }
      }
    }
  ]
}
POLICY

  inline_policy {
    name   = "eks-autoscaler-${var.environment}"
    policy = <<-EOF
  {
  	"Version": "2012-10-17",
  	"Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup"
        ],
        "Resource": "*",
        "Condition": {
          "StringEquals": {
              "aws:ResourceTag/k8s.io/cluster-autoscaler/${var.environment}-eks": "owned"
          }
        }
      },
      {
        "Sid": "VisualEditor1",
        "Effect": "Allow",
        "Action": [
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeAutoScalingGroups",
          "ec2:DescribeLaunchTemplateVersions",
          "autoscaling:DescribeTags",
          "autoscaling:DescribeLaunchConfigurations"
        ],
        "Resource": "*"
      }
    ]
  }
    EOF
  }
}