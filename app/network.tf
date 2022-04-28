module "shared_vpc" {
  source         = "../src/modules/composite/vpc"
  environment    = var.environment
  company_name   = var.company_name
  vpc_cidr_block = var.app_vpc_cidr
  kms_key_arn    = module.main_key.key_arn
  vpc_name       = "services"
  region         = var.region
  tags           = var.tags
}

module "rds_security_group" {
  source              = "../src/modules/simple/vpc_security_group"
  environment         = var.environment
  company_name        = var.company_name
  tags                = var.tags
  security_group_name = "rds"
  vpc_id              = module.shared_vpc.vpc_id
  ingress_rules = concat(var.database_security_group_additional_rules, [
    {
      description = "All traffic from private VPC"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_block  = var.app_vpc_cidr
    },
    {
      description = "Auth0"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_block  = "18.232.225.224/32"
    },
    {
      description = "Auth0"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_block  = "34.233.19.82/32"
    },
    {
      description = "Auth0"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_block  = "52.204.128.250/32"
    },
    {
      description = "Auth0"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_block  = "3.132.201.78/32"
    },
    {
      description = "Auth0"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_block  = "3.19.44.88/32"
    },
    {
      description = "Auth0"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_block  = "3.20.244.231/32"
    }
  ])
}

module "shared_launch_template_security_group" {
  source              = "../src/modules/simple/vpc_security_group"
  environment         = var.environment
  company_name        = var.company_name
  security_group_name = "shared_launch_template"
  vpc_id              = module.shared_vpc.vpc_id
  tags                = var.tags
  sg_ingress_rules = [{
    description     = "All bastion SSH traffic"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [module.shared_bastion_security_group.security_group_id]
    },
    {
      description     = "All traffic from load balancer security group"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      security_groups = [module.shared_load_balancer_security_group.security_group_id]
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
      description = "Allow all outbound traffic"
    }
  ]
}

module "shared_ecs_service_security_group" {
  source              = "../src/modules/simple/vpc_security_group"
  environment         = var.environment
  company_name        = var.company_name
  tags                = var.tags
  security_group_name = "shared-ecs-service"
  vpc_id              = module.shared_vpc.vpc_id
  sg_ingress_rules = [{
    description     = "All traffic from load balancer security group"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [module.shared_load_balancer_security_group.security_group_id]
  }]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
      description = "Allow all outbound traffic"
    }
  ]
}

module "database_access_security_group" {
  source              = "../src/modules/simple/vpc_security_group"
  environment         = var.environment
  company_name        = var.company_name
  tags                = var.tags
  security_group_name = "database-access"
  vpc_id              = module.shared_vpc.vpc_id
  egress_rules = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_block  = var.app_vpc_cidr
      description = "Allow all outbound traffic"
    }
  ]
}

module "shared_load_balancer_security_group" {
  source              = "../src/modules/simple/vpc_security_group"
  environment         = var.environment
  company_name        = var.company_name
  tags                = var.tags
  security_group_name = "alb"
  vpc_id              = module.shared_vpc.vpc_id
  ingress_rules = [
    {
      description = "Allow 443 from Internet"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
      description = "Allow all outbound traffic"
    }
  ]
}

module "shared_bastion_security_group" {
  source              = "../src/modules/simple/vpc_security_group"
  environment         = var.environment
  company_name        = var.company_name
  tags                = var.tags
  security_group_name = "shared_bastion"
  vpc_id              = module.shared_vpc.vpc_id
  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "Allow all"
    },
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
      description = "Allow all outbound traffic"
    }
  ]
}
