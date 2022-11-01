resource "aws_db_subnet_group" "default" {
  name       = "${var.company_name}-${var.environment}-${var.cluster_name}"
  subnet_ids = var.private_subnets
  tags       = var.tags
}

resource "aws_db_subnet_group" "public" {
  count      = var.use_only_private_subnets == true ? 0 : 1
  name       = "${var.company_name}-${var.environment}-${var.cluster_name}-public"
  subnet_ids = var.public_subnets
  tags       = var.tags
}

resource "aws_db_parameter_group" "ssl_param_group" {
  name   = "${var.company_name}-${var.environment}-${var.cluster_name}"
  tags   = var.tags
  family = "postgres11"

  parameter {
    name  = "rds.force_ssl"
    value = 1
  }

  parameter {
    name  = "log_min_duration_statement"
    value = 5000
  }
}

locals {
  name_prefix   = "${var.company_name}-${var.environment}-${var.cluster_name}"
  instance_name = "${local.name_prefix}-${var.name_override}"
}

resource "aws_db_instance" "new_public" {
  identifier                 = local.instance_name
  allocated_storage          = 100
  engine                     = "postgres"
  engine_version             = "11.13"
  auto_minor_version_upgrade = false
  deletion_protection        = true
  multi_az                   = true
  publicly_accessible        = true
  vpc_security_group_ids     = [var.security_group]
  instance_class             = var.instance_type
  name                       = var.initial_database
  kms_key_id                 = var.kms_key_arn
  db_subnet_group_name       = var.use_only_private_subnets == true ? aws_db_subnet_group.default.name : aws_db_subnet_group.public[0].name
  username                   = var.master_username
  password                   = var.master_password
  parameter_group_name       = aws_db_parameter_group.ssl_param_group.id
  //  availability_zone        = var.availability_zone
  backup_retention_period  = 7
  backup_window            = "07:31-11:31"
  delete_automated_backups = false
  copy_tags_to_snapshot    = true
  snapshot_identifier      = var.snapshot_identifier != "" ? var.snapshot_identifier : null
  enabled_cloudwatch_logs_exports = [
    "postgresql",
  ]
  maintenance_window        = "sun:12:04-sun:12:34"
  max_allocated_storage     = 200
  monitoring_interval       = 0
  skip_final_snapshot       = var.skip_final_snapshot
  storage_encrypted         = true
  final_snapshot_identifier = var.cluster_name
  tags                      = var.tags
  lifecycle {
    ignore_changes = [
      kms_key_id
    ]
  }
}

resource "aws_db_instance" "read_replica" {
  count                    = var.deploy_read_replica == true ? 1 : 0
  identifier               = "${local.instance_name}-reader"
  allocated_storage        = 100
  multi_az                 = true
  publicly_accessible      = true
  vpc_security_group_ids   = [var.security_group]
  deletion_protection      = true
  instance_class           = var.reader_instance_type
  name                     = var.initial_database
  kms_key_id               = var.kms_key_arn
  replicate_source_db      = aws_db_instance.new_public.id
  parameter_group_name     = aws_db_parameter_group.ssl_param_group.id
  delete_automated_backups = false
  copy_tags_to_snapshot    = true
  snapshot_identifier      = var.snapshot_identifier != "" ? var.snapshot_identifier : null
  enabled_cloudwatch_logs_exports = [
    "postgresql",
  ]
  maintenance_window    = "sun:12:04-sun:12:34"
  max_allocated_storage = 200
  monitoring_interval   = 0
  skip_final_snapshot   = true
  storage_encrypted     = true
  tags                  = var.tags
}


resource "aws_cloudwatch_metric_alarm" "cpu-usage" {
  alarm_name          = "${local.name_prefix}-cpu-usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "600"
  statistic           = "Average"
  threshold           = "90"
  alarm_actions       = [var.sns_arn]
  ok_actions          = [var.sns_arn]
  treat_missing_data  = "notBreaching"
  dimensions = {
    DBInstanceIdentifier = local.instance_name
  }
}

resource "aws_cloudwatch_metric_alarm" "free-space" {
  alarm_name          = "${local.name_prefix}-free-space"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "10737418240" # 10 GB
  alarm_actions       = [var.sns_arn]
  ok_actions          = [var.sns_arn]
  treat_missing_data  = "notBreaching"
  dimensions = {
    DBInstanceIdentifier = local.instance_name
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu-usage-reader" {
  count               = var.deploy_read_replica == true ? 1 : 0
  alarm_name          = "${local.name_prefix}-cpu-usage-reader"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "90"
  alarm_actions       = [var.sns_arn]
  ok_actions          = [var.sns_arn]
  treat_missing_data  = "notBreaching"
  dimensions = {
    DBInstanceIdentifier = "${local.instance_name}-reader"
  }
}

resource "aws_cloudwatch_metric_alarm" "free-space-reader" {
  count               = var.deploy_read_replica == true ? 1 : 0
  alarm_name          = "${local.name_prefix}-free-space-reader"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "10737418240" # 10 GB
  alarm_actions       = [var.sns_arn]
  ok_actions          = [var.sns_arn]
  treat_missing_data  = "notBreaching"
  dimensions = {
    DBInstanceIdentifier = "${local.instance_name}-reader"
  }
}