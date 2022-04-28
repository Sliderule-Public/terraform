data "aws_ami" "ecs" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/*/ubuntu-focal-20.04-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

module "shared_ecs_load_balancer" {
  source             = "../src/modules/simple/load_balancer"
  environment        = var.environment
  company_name       = var.company_name
  tags               = var.tags
  load_balancer_name = "shared"
  cert_arn           = var.certificate_arn
  idle_timeout       = var.elb_idle_timeout
  subnets            = module.shared_vpc.public_subnet_ids_for_load_balancers
  vpc_id             = module.shared_vpc.vpc_id
  security_group_id  = module.shared_load_balancer_security_group.security_group_id
}

module "shared_ecs_auto_scaling_group" {
  source             = "../src/modules/simple/auto_scaling_group"
  environment        = var.environment
  tags               = var.tags
  desired_count      = 1
  launch_template_id = module.shared_ecs_launch_template.template_id
  company_name       = var.company_name
  subnets            = module.shared_vpc.private_subnet_ids
  group_name         = "ecs-hosts"
  region             = var.region
  set_count          = false
  max_count          = var.maximum_host_count
  min                = var.minimum_host_count
}

module "shared_ecs_launch_template" {
  source                      = "../src/modules/simple/launch_template"
  environment                 = var.environment
  company_name                = var.company_name
  tags                        = var.tags
  template_name               = "ecs"
  region                      = var.region
  associate_public_ip_address = false
  instance_type               = "t3.xlarge"
  key_name                    = "${var.app_name}-services-${var.environment}"
  ami                         = var.ecs_host_ami != "" ? var.ecs_host_ami : data.aws_ami.ecs.image_id
  user_data                   = <<EOF
    #!/bin/bash
    echo ECS_CLUSTER=${var.company_name}-${var.environment}-services >> /etc/ecs/ecs.config
  EOF
  instance_profile_name       = module.ecs_shared_instance_profile.profile_name
  vpc_security_group_ids = [
    module.shared_launch_template_security_group.security_group_id,
    module.database_access_security_group.security_group_id
  ]
}

module "shared_bastion_launch_template" {
  source                = "../src/modules/simple/launch_template"
  environment           = var.environment
  company_name          = var.company_name
  tags                  = var.tags
  template_name         = "bastion"
  region                = var.region
  instance_type         = "t3.small"
  key_name              = "${var.app_name}-services-${var.environment}"
  ami                   = var.bastion_ami != "" ? var.bastion_ami : data.aws_ami.ubuntu.image_id
  instance_profile_name = module.bastion_instance_profile.profile_name
  vpc_security_group_ids = [
    module.shared_bastion_security_group.security_group_id,
    module.database_access_security_group.security_group_id
  ]
  user_data                   = <<EOF
    #!/bin/bash
    amazon-linux-extras install epel -y
    yum update -y
    yum install postgresql -y
  EOF
}

module "shared_bastion_auto_scaling_group" {
  source             = "../src/modules/simple/auto_scaling_group"
  environment        = var.environment
  company_name       = var.company_name
  tags               = var.tags
  subnets            = module.shared_vpc.public_subnet_ids
  group_name         = "bastion"
  region             = var.region
  desired_count      = 1
  max_count          = 1
  min                = 1
  set_count          = true
  launch_template_id = module.shared_bastion_launch_template.template_id
}
