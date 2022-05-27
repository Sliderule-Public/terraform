resource "aws_ecs_capacity_provider" "provider" {
  name = "${var.company_name}-${var.environment}-${var.cluster_name}-provider"
  tags = var.tags

  auto_scaling_group_provider {
    auto_scaling_group_arn = var.autoscaling_group_arn

    managed_scaling {
      maximum_scaling_step_size = 4
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }
}

resource "aws_ecs_cluster" "foo" {
  name               = "${var.company_name}-${var.environment}-${var.cluster_name}"
  tags               = var.tags
  capacity_providers = [aws_ecs_capacity_provider.provider.name]
  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.provider.name
  }
}

