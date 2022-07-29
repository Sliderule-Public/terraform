module "rds_role" {
  environment  = var.environment
  company_name = var.company_name
  tags         = var.tags
  source       = "../src/modules/simple/iam_role"
  role_name    = "rds"
  service      = "rds.amazonaws.com"
  policy       = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:CreateLogGroups"
        ],
        "Resource": "*"
      }
    ]
  }
  EOF
}

module "ecs_host_role" {
  environment  = var.environment
  company_name = var.company_name
  tags         = var.tags
  source       = "../src/modules/simple/iam_role"
  role_name    = "ecs_host"
  service      = "ec2.amazonaws.com"
  policy       = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ec2:DescribeTags",
          "ecs:CreateCluster",
          "ecs:DeregisterContainerInstance",
          "ecs:DiscoverPollEndpoint",
          "ecs:Poll",
          "ecs:RegisterContainerInstance",
          "ecs:StartTelemetrySession",
          "ecs:UpdateContainerInstancesState",
          "ecs:Submit*",
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:GetLifecyclePolicy",
          "ecr:GetLifecyclePolicyPreview",
          "ecr:ListTagsForResource",
          "ecr:DescribeImageScanFindings",
          "ecr:CompleteLayerUpload",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "*"
      }
    ]
  }
  EOF
}

module "bastion_role" {
  environment  = var.environment
  company_name = var.company_name
  tags         = var.tags
  source       = "../src/modules/simple/iam_role"
  role_name    = "bastion"
  service      = "ec2.amazonaws.com"
  policy       = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ec2:DescribeTags",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "sqs:*"
        ],
        "Resource": "${module.sqs.arn}"
      }
    ]
  }
  EOF
}

module "ecs_task_role" {
  environment  = var.environment
  company_name = var.company_name
  tags         = var.tags
  source       = "../src/modules/simple/iam_role"
  role_name    = "ecs-tasks"
  service      = "ecs-tasks.amazonaws.com"
  policy       = data.aws_iam_policy_document.task.json
}

module "ecs_host_ssm_policy_attachment" {
  source     = "../src/modules/simple/iam_role_policy_attachment"
  role_arn   = module.ecs_host_role.role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  tags       = var.tags
}

module "bastion_host_ssm_policy_attachment" {
  source     = "../src/modules/simple/iam_role_policy_attachment"
  role_arn   = module.bastion_role.role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  tags       = var.tags
}

module "ecs_task_execution_role" {
  environment  = var.environment
  company_name = var.company_name
  tags         = var.tags
  source       = "../src/modules/simple/iam_role"
  role_name    = "task-execution"
  service      = "ecs-tasks.amazonaws.com"
  policy       = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ec2:DescribeTags",
          "ecs:CreateCluster",
          "ecs:DeregisterContainerInstance",
          "ecs:DiscoverPollEndpoint",
          "ecs:Poll",
          "ecs:RegisterContainerInstance",
          "ecs:StartTelemetrySession",
          "ecs:UpdateContainerInstancesState",
          "ecs:Submit*",
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "s3:Describe*",
          "s3:Get*"
        ],
        "Resource": [
          "${module.infrastructure_bucket.bucket_arn}",
          "${module.infrastructure_bucket.bucket_arn}/*"
        ]
      }
    ]
  }
  EOF
}

module "prometheus_role" {
  environment  = var.environment
  company_name = var.company_name
  tags         = var.tags
  source       = "../src/modules/simple/iam_role"
  role_name    = "prometheus"
  service      = "ec2.amazonaws.com"
  policy       = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:*"
        ],
        "Resource": [
          "${module.infrastructure_bucket.bucket_arn}/env-files/prometheus/*",
          "${module.infrastructure_bucket.bucket_arn}/artifacts/prometheus/*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:DescribeTags",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "*"
      }
    ]
  }
  EOF
}

module "ecs_shared_instance_profile" {
  environment  = var.environment
  company_name = var.company_name
  tags         = var.tags
  source       = "../src/modules/simple/instance_profile"
  profile_name = "ecs-host"
  role_name    = module.ecs_host_role.role_name
}

module "bastion_instance_profile" {
  environment  = var.environment
  company_name = var.company_name
  tags         = var.tags
  source       = "../src/modules/simple/instance_profile"
  profile_name = "bastion"
  role_name    = module.bastion_role.role_name
}

data "aws_iam_policy_document" "task" {
  // Parse all statements passed by user
  dynamic "statement" {
    for_each = var.server_iam_role_policy_statements
    content {
      effect    = statement.value["effect"]
      actions   = statement.value["actions"]
      resources = statement.value["resources"]
    }
  }

  // Allow role to publish to SQS
  statement {
    effect    = "Allow"
    actions   = ["sqs:*"]
    resources = [module.sqs.arn]
  }

  statement {
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      "${module.server_docs_bucket.bucket_arn}/*",
      module.server_docs_bucket.bucket_arn
    ]
  }

  statement {
    effect    = "Allow"
    actions   = ["ec2:DescribeTags", "logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "eks_task" {
  count = var.deploy_eks == true ? 1 : 0
  dynamic "statement" {
    for_each = var.server_iam_role_policy_statements
    content {
      effect    = statement.value["effect"]
      actions   = statement.value["actions"]
      resources = statement.value["resources"]
    }
  }

  // Allow role to publish to SQS
  statement {
    effect    = "Allow"
    actions   = ["sqs:*"]
    resources = [module.sqs.arn]
  }

  statement {
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      "${module.server_docs_bucket.bucket_arn}/*",
      module.server_docs_bucket.bucket_arn
    ]
  }

  statement {
    effect    = "Allow"
    actions   = ["ec2:DescribeTags", "logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["*"]
  }
}

data "tls_certificate" "main" {
  count = var.deploy_eks == true ? 1 : 0
  url = aws_eks_cluster.main[0].identity[0].oidc[0].issuer
}
resource "aws_iam_openid_connect_provider" "main" {
  count = var.deploy_eks == true ? 1 : 0
  url = aws_eks_cluster.main[0].identity[0].oidc[0].issuer

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [
    data.tls_certificate.main[0].certificates.0.sha1_fingerprint
  ]
}

resource "aws_iam_role" "eks" {
  count = var.deploy_eks == true ? 1 : 0
  name  = "${var.environment}-eks"

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  ]

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
    }
  ]
}
POLICY
}