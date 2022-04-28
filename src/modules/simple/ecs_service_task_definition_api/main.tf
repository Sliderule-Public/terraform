resource "aws_cloudwatch_log_group" "loggroup" {
  name       = "/ecs/${var.company_name}/${var.environment}/${var.task_name}"
  kms_key_id = var.kms_key_arn
  tags       = var.tags
}

resource "aws_cloudwatch_log_group" "loggroup_prometheus" {
  name       = "/ecs/${var.company_name}/${var.environment}/${var.task_name}/prometheus"
  kms_key_id = var.kms_key_arn
  tags       = var.tags
}

locals {
  additional_port_mappings = concat([{
    containerPort: var.container_port,
    hostPort: var.container_port
  }], [{
    containerPort: 9520,
    hostPort: 9520
  }])
}


resource "aws_ecs_task_definition" "service" {
  family                = "${var.company_name}-${var.environment}-${var.task_name}"
  tags                  = var.tags
  execution_role_arn    = var.execution_role_arn
  task_role_arn         = var.task_role_arn
  network_mode          = "host"
  container_definitions = <<EOF
  [
    {
      "name": "${var.task_name}",
      "image": "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.image_name}:${var.image_tag}",
      "cpu": ${var.cpu},
      "memory": ${var.memory},
      "essential": true,
      "portMappings": ${jsonencode(local.additional_port_mappings)},
      "environment": ${jsonencode(var.environmentOverrides)},
      "linuxParameters": ${jsonencode(var.linuxParameters)},
      "readonlyRootFilesystem": ${var.read_only},
      "user": "${var.user}",
      "environmentFiles": ${jsonencode(var.environmentFiles)},
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-region": "${var.region}",
          "awslogs-group": "/ecs/${var.company_name}/${var.environment}/${var.task_name}"
        }
      }
    },
    {
      "name": "prometheus",
      "image": "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/prometheus:${var.image_tag}",
      "cpu": 128,
      "memory": 256,
      "essential": true,
      "environment": ${jsonencode(var.environmentOverrides)},
      "portMappings": [
        {
          "containerPort": 12346,
          "hostPort": 12346
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-region": "${var.region}",
          "awslogs-group": "/ecs/${var.company_name}/${var.environment}/${var.task_name}/prometheus"
        }
      }
    }
  ]
  EOF
}
