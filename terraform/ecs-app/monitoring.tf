resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name          = "${var.company_name}-${var.environment}-elb-504s"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "HTTPCode_Target_504_Count"
  namespace           = "AWS/EC2"
  period              = "10"
  statistic           = "Minimum"
  threshold           = "1"
  alarm_actions       = [aws_sns_topic.alarms.arn]
  dimensions = {
    LoadBalancer = module.shared_ecs_load_balancer.lb_arn
  }
}