resource "aws_iam_instance_profile" "profile" {
  name = substr("${var.company_name}-${var.environment}-${var.role_name}", 0, 64)
  role = var.role_name
  tags = var.tags
}
