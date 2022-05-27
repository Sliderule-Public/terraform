resource "aws_iam_service_linked_role" "ecs" {
  count            = var.deploy_ecs_service_linked_role == true ? 1 : 0
  aws_service_name = "ecs.amazonaws.com"
}

module "external_role" {
  environment             = "shared"
  company_name            = var.company_name
  source                  = "../src/modules/simple/cross_account_iam_role"
  external_aws_account_id = var.external_aws_account_id
  role_name               = "external"
  policy                  = data.aws_iam_policy_document.cross_account.json

  assume_role_conditions = [
    {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.external_id]
    }
  ]
}

data "aws_iam_policy_document" "cross_account" {
  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchDeleteImage",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:Describe*",
      "ecr:Get*",
      "ecr:InitiateLayerUpload",
      "ecr:ListImages",
      "ecr:ListTagsForResource",
      "ecr:PutImage",
      "ecr:ReplicateImage",
      "ecr:StartImageScan",
      "ecr:TagResource",
      "ecr:UntagResource",
      "ecr:UploadLayerPart"
    ]

    resources = [
      "arn:aws:ecr:*:${local.account_id}:repository/shieldrule-api",
      "arn:aws:ecr:*:${local.account_id}:repository/shieldrule-docs",
      "arn:aws:ecr:*:${local.account_id}:repository/shieldrule-web",
      "arn:aws:ecr:*:${local.account_id}:repository/prometheus"
    ]
  }

  statement {
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    resources = [for environment in var.ecs_environments_touchable_by_external_account : "arn:aws:ecs:${var.region}:${local.account_id}:service/${var.company_name}-${environment}-${var.service_name}-*"]
    actions = [
      "ecs:UpdateService"
    ]
  }

  statement {
    resources = [for environment in var.ecs_environments_touchable_by_external_account : "arn:aws:ecs:${var.region}:${local.account_id}:task/${var.company_name}-${environment}-services/*"]
    actions = [
      "ecs:DescribeTasks",
      "ecs:ListTasks",
      "ecs:RunTask",
      "ecs:StartTask",
      "ecs:StopTask",
    ]
  }

  statement {
    resources = [for environment in var.ecs_environments_touchable_by_external_account : "arn:aws:ecs:${var.region}:${local.account_id}:container-instance/${var.company_name}-${environment}-services/*"]
    actions = [
      "ecs:DescribeContainerInstances",
      "ecs:UpdateContainerAgent"
    ]
  }

  statement {
    resources = [for environment in var.ecs_environments_touchable_by_external_account : "arn:aws:ecs:${var.region}:${local.account_id}:log-group:/ecs/${var.company_name}/${environment}/${var.service_name}*"]
    actions = [
      "logs:Describe*",
      "logs:Get*",
      "logs:List*",
      "logs:StartQuery",
      "logs:StopQuery",
      "logs:TestMetricFilter",
      "logs:FilterLogEvents"
    ]
  }
}