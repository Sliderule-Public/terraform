resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name          = "${var.company_name}-${var.environment}-${var.module_name}"
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = "5"
  alarm_actions       = var.alarm_actions
  dimensions = {
    TargetGroup  = var.target_group_arn
    LoadBalancer = var.load_balancer_arn
  }
}