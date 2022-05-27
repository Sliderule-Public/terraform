resource "aws_cloudwatch_log_group" "loggroup" {
  name = var.log_group_name
  tags = var.tags
}
