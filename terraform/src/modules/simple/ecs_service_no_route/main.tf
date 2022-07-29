resource "aws_ecs_service" "service" {
  name            = "${var.company_name}-${var.environment}-${var.service_name}"
  tags            = var.tags
  cluster         = var.cluster_id
  task_definition = var.task_definition_arn
  desired_count   = var.desired_count
  network_configuration {
    subnets         = var.subnets
    security_groups = var.vpc_security_group_ids
  }

  dynamic "capacity_provider_strategy" {
    for_each = length(var.capacity_provider_name) > 0 ? [1] : []
    content {
      capacity_provider = var.capacity_provider_name
      weight            = 1
    }
  }
}