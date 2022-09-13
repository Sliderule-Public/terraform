resource "aws_launch_template" "template" {
  name          = "${var.company_name}-${var.environment}-${var.template_name}"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = base64encode(var.user_data)

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 60
      encrypted   = true
    }
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip_address
    security_groups             = var.vpc_security_group_ids
  }

  iam_instance_profile {
    name = var.instance_profile_name
  }

  lifecycle {
    ignore_changes = [iam_instance_profile]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.company_name}-${var.environment}-${var.template_name}"
    }
  }
  tags = var.tags
}
