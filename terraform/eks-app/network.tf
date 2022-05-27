module "shared_vpc" {
  count          = var.create_vpc == true ? 1 : 0
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
  vpc_id              = local.vpc_id
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

module "pod_security_group" {
  source              = "../src/modules/simple/vpc_security_group"
  environment         = var.environment
  company_name        = var.company_name
  tags                = var.tags
  security_group_name = "eks-pods"
  vpc_id              = local.vpc_id
  ingress_rules = [
    {
      from_port   = var.web_eks_port
      to_port     = var.web_eks_port
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "web eks port"
    },
    {
      from_port   = var.docs_eks_port
      to_port     = var.docs_eks_port
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "docs eks port"
    },
    {
      from_port   = var.api_eks_port
      to_port     = var.api_eks_port
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "api eks port"
    }
  ]
}
