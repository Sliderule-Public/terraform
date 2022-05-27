resource "aws_autoscaling_group" "group" {
  name                = "${var.company_name}-${var.environment}-${var.group_name}"
  desired_capacity    = var.set_count ? var.desired_count : null
  max_size            = var.max_count
  min_size            = var.min
  vpc_zone_identifier = var.subnets

  launch_configuration = var.launch_configuration_name

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

