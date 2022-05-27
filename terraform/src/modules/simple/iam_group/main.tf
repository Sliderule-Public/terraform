resource "aws_iam_group" "group" {
  name = substr("${var.company_name}-${var.app_name}-${var.environment}-${var.group_name}", 0, 64)
  tags = var.tags
}
