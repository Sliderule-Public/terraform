module "shieldrule_database_key" {
  source       = "../src/modules/simple/kms_key"
  environment  = var.environment
  region       = var.region
  company_name = var.company_name
  account_id   = local.account_id
  key_name     = "shieldrule-database"
  tags         = var.tags
  usage_grantee_arns = concat(var.kms_grantees, [
    var.author
  ])
}

module "step_workflow_key" {
  source       = "../src/modules/simple/kms_key"
  environment  = var.environment
  region       = var.region
  company_name = var.company_name
  account_id   = local.account_id
  key_name     = "step-workflow"
  tags         = var.tags
  usage_grantee_arns = concat(var.kms_grantees, [
    var.author
  ])
}


module "cw_key" {
  source       = "../src/modules/simple/kms_key"
  environment  = var.environment
  policy       = data.aws_iam_policy_document.main_kms_key.json
  region       = var.region
  company_name = var.company_name
  account_id   = local.account_id
  key_name     = "cloudwatch"
  tags         = var.tags
  usage_grantee_arns = concat(var.kms_grantees, [
    var.author
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
}
