module "main_key" {
  source       = "../src/modules/simple/kms_key"
  environment  = var.environment
  region       = var.region
  company_name = var.company_name
  account_id   = local.account_id
  key_name     = "main-key"
  tags         = var.tags
  policy       = data.aws_iam_policy_document.main_kms_key.json
  usage_grantee_arns = concat(var.kms_grantees, [
    aws_iam_role.eks-tasks.arn,
  ])
}

module "rds_key" {
  source       = "../src/modules/simple/kms_key"
  environment  = var.environment
  region       = var.region
  company_name = var.company_name
  account_id   = local.account_id
  key_name     = "rds-key"
  tags         = var.tags
  usage_grantee_arns = concat(var.kms_grantees, [
    module.rds_role.role_arn
  ])
}

data "aws_iam_policy_document" "main_kms_key" {
  statement {
    effect = "Allow"
    actions = [
      "kms:*"
    ]
    resources = [
      "*"
    ]
    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      type        = "AWS"
    }
  }
  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = [
      "*"
    ]
    principals {
      identifiers = ["logs.us-west-1.amazonaws.com"]
      type        = "Service"
    }
  }

  # Additional services to grant access. One example is SES
  dynamic statement {
    for_each = length(var.services_to_grant_kms_access_to) > 0 ? [1] : []
    content {
      effect = "Allow"
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:Describe*"
      ]
      resources = [
        "*"
      ]
      principals {
        identifiers = var.services_to_grant_kms_access_to
        type        = "Service"
      }
    }
  }
}

module "sns_key" {
  source       = "../src/modules/simple/kms_key"
  environment  = var.environment
  region       = var.region
  company_name = var.company_name
  account_id   = local.account_id
  key_name     = "sns-key"
  tags         = var.tags
  policy       = data.aws_iam_policy_document.sns_kms_key.json
  usage_grantee_arns = var.kms_grantees
}

data "aws_iam_policy_document" "sns_kms_key" {
  statement {
    effect = "Allow"
    actions = [
      "kms:*"
    ]
    resources = [
      "*"
    ]
    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      type        = "AWS"
    }
  }
  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = [
      "*"
    ]
    principals {
      identifiers = [
        "cloudwatch.amazonaws.com",
        "events.amazonaws.com",
        "events.rds.amazonaws.com",
        "logs.${var.region}.amazonaws.com"
      ]
      type = "Service"
    }
  }

  # Additional services to grant access. One example is SES
  dynamic "statement" {
    for_each = length(var.iam_arns_to_grant_sns_kms_access_to) > 0 ? [1] : []
    content {
      effect = "Allow"
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:Describe*"
      ]
      resources = [
        "*"
      ]
      principals {
        identifiers = var.iam_arns_to_grant_sns_kms_access_to
        type        = "AWS"
      }
    }
  }
}