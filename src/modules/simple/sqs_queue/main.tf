resource "aws_sqs_queue" "terraform_queue" {
  name                      = substr("${var.company_name}-${var.environment}-${var.name}", 0, 64)
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  tags = var.tags
}