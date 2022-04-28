resource "aws_kms_key" "key" {
  deletion_window_in_days = 10
  enable_key_rotation     = true
  policy = var.policy
  tags = var.tags
}

resource "aws_kms_grant" "grant" {
  count             = length(var.usage_grantee_arns)
  name              = "${var.company_name}-${var.environment}-${var.key_name}"
  key_id            = aws_kms_key.key.key_id
  grantee_principal = var.usage_grantee_arns[count.index]
  operations        = ["Encrypt", "Decrypt", "GenerateDataKey", "DescribeKey"]
}

resource "aws_kms_alias" "alias" {
  name          = "alias/${var.company_name}-${var.environment}-${var.key_name}"
  target_key_id = aws_kms_key.key.key_id
}
