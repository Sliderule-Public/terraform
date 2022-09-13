resource "random_integer" "priority" {
  min = 1
  max = 50000
}


resource "aws_lb_target_group" "tg" {
  name                 = substr("${var.company_name}-${var.environment}-${var.service_name}", 0, 32)
  port                 = var.container_port
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  target_type          = var.target_type
  deregistration_delay = 10
  health_check {
    enabled             = var.enable_health_check
    matcher             = "200-304,401"
    protocol            = "HTTP"
    path                = var.health_check_path
    timeout             = 30
    interval            = 61
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = var.tags
}

resource "aws_lb_target_group" "grpc" {
  name                 = substr("${var.environment}-${var.service_name}-grpc", 0, 32)
  port                 = 9520
  protocol             = "HTTP"
  protocol_version     = "GRPC"
  vpc_id               = var.vpc_id
  target_type          = var.target_type
  deregistration_delay = 10
  health_check {
    enabled             = var.enable_health_check
    matcher             = "0-99"
    protocol            = "HTTP"
    path                = "/'"
    timeout             = var.api_health_check_timeout
    interval            = var.api_health_check_interval
    healthy_threshold   = var.api_healthy_threshold
    unhealthy_threshold = var.api_unhealthy_threshold
  }
  tags = var.tags
}

resource "aws_ecs_service" "service" {
  name                               = "${var.company_name}-${var.environment}-${var.service_name}"
  tags                               = var.tags
  cluster                            = var.cluster_id
  task_definition                    = var.task_definition_arn
  desired_count                      = var.desired_count
  deployment_minimum_healthy_percent = 50

  dynamic "capacity_provider_strategy" {
    for_each = length(var.capacity_provider_name) > 0 ? [1] : []
    content {
      capacity_provider = var.capacity_provider_name
      weight            = 1
    }
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = var.container_to_forward_to
    container_port   = var.container_port
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.grpc.arn
    container_name   = var.container_to_forward_to
    container_port   = 9520
  }

  health_check_grace_period_seconds = 60

}

resource "aws_lb_listener_rule" "static" {
  listener_arn = var.listener_arn
  priority     = random_integer.priority.result
  tags         = var.tags

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }

  condition {
    host_header {
      values = var.host_listeners
    }
  }
}

resource "aws_lb_listener_rule" "grpc" {
  listener_arn = var.listener_arn
  priority     = 101
  tags         = var.tags

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.grpc.arn
  }

  condition {
    host_header {
      values = flatten([for name in var.domain_names : "${local.grpc_subdomain}.${name}"])
    }
  }
}

locals {
  grpc_subdomain = var.environment == "prod" ? "grpc" : "grpc-${var.environment}"
  alarm_prefix   = replace(trim(substr("${var.company_name}-${var.environment}-${var.service_name}", 0, 32), "-"), "/(targetgroup/)|(/\\w+$)/", "")
}

data "aws_lb" "main" {
  count = var.load_balancer_arn != 0 ? 1 : 0
  arn   = var.load_balancer_arn
}

resource "aws_cloudwatch_metric_alarm" "target-healthy-count" {
  count               = var.load_balancer_arn != 0 ? 1 : 0
  alarm_name          = "${local.alarm_prefix}-Healthy-Count"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Minimum"
  threshold           = "1"

  dimensions = {
    LoadBalancer = data.aws_lb.main[0].arn_suffix
    TargetGroup  = aws_lb_target_group.tg.arn_suffix
  }

  alarm_description  = "Trigger an alert when ${trim(substr("${var.company_name}-${var.environment}-${var.service_name}", 0, 32), "-")} has 0 healthy hosts"
  alarm_actions      = [var.sns_arn]
  ok_actions         = [var.sns_arn]
  treat_missing_data = "breaching"
}

resource "aws_cloudwatch_metric_alarm" "target-response-time" {
  count               = var.load_balancer_arn != 0 ? 1 : 0
  alarm_name          = "${local.alarm_prefix}-response-time"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = "180"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    LoadBalancer = data.aws_lb.main[0].arn_suffix
    TargetGroup  = aws_lb_target_group.tg.arn_suffix
  }
  alarm_actions      = [var.sns_arn]
  ok_actions         = [var.sns_arn]
  treat_missing_data = "notBreaching"
}


resource "aws_cloudwatch_metric_alarm" "target-4xx-count" {
  count               = var.load_balancer_arn != 0 ? 1 : 0
  alarm_name          = "${local.alarm_prefix}-4xx-count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "HTTPCode_Target_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "180"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    LoadBalancer = data.aws_lb.main[0].arn_suffix
    TargetGroup  = aws_lb_target_group.tg.arn_suffix
  }
  alarm_actions      = [var.sns_arn]
  ok_actions         = [var.sns_arn]
  treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "target-5xx-count" {
  count               = var.load_balancer_arn != 0 ? 1 : 0
  alarm_name          = "${local.alarm_prefix}-5xx-count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "180"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    LoadBalancer = data.aws_lb.main[0].arn_suffix
    TargetGroup  = aws_lb_target_group.tg.arn_suffix
  }
  alarm_actions      = [var.sns_arn]
  ok_actions         = [var.sns_arn]
  treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "service-cpu" {
  alarm_name          = "${local.alarm_prefix}-service-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "600"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    ClusterName = "${var.company_name}-${var.environment}-services"
    ServiceName = aws_ecs_service.service.name
  }
  alarm_actions      = [var.sns_arn]
  ok_actions         = [var.sns_arn]
  treat_missing_data = "breaching"
}

resource "aws_cloudwatch_metric_alarm" "service-memory" {
  alarm_name          = "${local.alarm_prefix}-service-memory"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    ClusterName = "${var.company_name}-${var.environment}-services"
    ServiceName = aws_ecs_service.service.name
  }
  alarm_actions      = [var.sns_arn]
  ok_actions         = [var.sns_arn]
  treat_missing_data = "breaching"
}
