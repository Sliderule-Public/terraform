resource "aws_sns_topic" "alarms" {
  name              = "${var.company_name}-${var.environment}-alarms"
  kms_master_key_id = module.sns_key.key_id
}

resource "aws_sns_topic_subscription" "ecs_alarms_email_subscription" {
  count     = length(var.alarms_email_recipients)
  topic_arn = aws_sns_topic.alarms.arn
  protocol  = "email"
  endpoint  = var.alarms_email_recipients[count.index]
}
