resource "aws_iam_role" "role" {
  name               = substr("${var.company_name}-${var.environment}-${var.role_name}", 0, 64)
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = [
        var.external_aws_account_id
      ]
    }

    dynamic "condition" {
      for_each = var.assume_role_conditions
      content {
        test     = condition.value["test"]
        variable = condition.value["variable"]
        values   = condition.value["values"]
      }
    }
  }
}

resource "aws_iam_role_policy" "policy" {
  role   = aws_iam_role.role.name
  policy = var.policy
}

