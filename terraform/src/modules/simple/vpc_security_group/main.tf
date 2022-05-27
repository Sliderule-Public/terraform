resource "aws_security_group" "group" {
  name   = "${var.company_name}-${var.environment}-${var.security_group_name}"
  vpc_id = var.vpc_id
  tags = var.tags

  dynamic ingress {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value["from_port"]
      protocol    = ingress.value["protocol"]
      to_port     = ingress.value["to_port"]
      description = ingress.value["description"]
      cidr_blocks = [ingress.value["cidr_block"]]
    }
  }

  dynamic ingress {
    for_each = var.sg_ingress_rules
    content {
      from_port   = ingress.value["from_port"]
      protocol    = ingress.value["protocol"]
      to_port     = ingress.value["to_port"]
      description = ingress.value["description"]
      security_groups = ingress.value["security_groups"]
    }
  }

  dynamic egress {
    for_each = var.egress_rules
    content {
      from_port   = egress.value["from_port"]
      protocol    = egress.value["protocol"]
      to_port     = egress.value["to_port"]
      description = egress.value["description"]
      cidr_blocks = [egress.value["cidr_block"]]
    }
  }
}
