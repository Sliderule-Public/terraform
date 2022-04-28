resource "aws_iam_policy" "policy" {
  name   = substr("${var.company_name}-${var.app_name}-${var.environment}-${var.policy_name}", 0, 64)
  policy = var.policy
  tags   = var.tags
}

