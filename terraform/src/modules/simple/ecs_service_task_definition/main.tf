resource "aws_cloudwatch_log_group" "loggroup" {
  name       = "/ecs/${var.company_name}/${var.environment}/${var.task_name}"
  kms_key_id = var.kms_key_arn
  tags       = var.tags
}

locals {
  container_definition = {
    name                   = var.task_name
    image                  = "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.image_name}:${var.image_tag}"
    cpu                    = var.cpu
    memory                 = var.memory
    essential              = true
    environment            = var.environmentOverrides
    linuxParameters        = var.linuxParameters
    readonlyRootFilesystem = var.read_only
    user                   = var.user
    environmentFiles       = var.environmentFiles
    "portMappings" = var.container_port != null ? [
      {
        containerPort = var.container_port
      }
    ] : null
    logConfiguration = {
      logDriver = "awslogs"
      "options" = {
        awslogs-region = var.region
        awslogs-group  = "/ecs/${var.company_name}/${var.environment}/${var.task_name}"
      }
    }
  }
}


resource "aws_ecs_task_definition" "service" {
  family                = "${var.company_name}-${var.environment}-${var.task_name}"
  tags                  = var.tags
  execution_role_arn    = var.execution_role_arn
  task_role_arn         = var.task_role_arn
  network_mode          = "awsvpc"
  container_definitions = jsonencode([local.container_definition])
}
