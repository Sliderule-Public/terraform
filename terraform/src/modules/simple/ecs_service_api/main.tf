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
    timeout             = 10
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = var.tags
}

resource "aws_ecs_service" "service" {
  name            = "${var.company_name}-${var.environment}-${var.service_name}"
  tags            = var.tags
  cluster         = var.cluster_id
  task_definition = var.task_definition_arn
  desired_count   = var.desired_count

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
      values = flatten([for name in var.domain_names: "${local.grpc_subdomain}.${name}"])
    }
  }
}

locals {
  grpc_subdomain = var.environment == "prod" ? "grpc" : "grpc-${var.environment}"
}

data "aws_lb" "main" {
  count = var.load_balancer_arn != 0 ? 1 : 0
  arn   = var.load_balancer_arn
}

resource "aws_cloudwatch_metric_alarm" "target-healthy-count" {
  count               = var.load_balancer_arn != 0 ? 1 : 0
  alarm_name          = "${replace(trim(substr("${var.company_name}-${var.environment}-${var.service_name}", 0, 32), "-"), "/(targetgroup/)|(/\\w+$)/", "")}-Healthy-Count"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Average"
  threshold           = "0"

  dimensions = {
    LoadBalancer = data.aws_lb.main[0].arn_suffix
    TargetGroup  = aws_lb_target_group.tg.arn_suffix
  }

  alarm_description  = "Trigger an alert when ${trim(substr("${var.company_name}-${var.environment}-${var.service_name}", 0, 32), "-")} has 0 healthy hosts"
  alarm_actions      = [var.sns_arn]
  ok_actions         = [var.sns_arn]
  treat_missing_data = "breaching"
}
