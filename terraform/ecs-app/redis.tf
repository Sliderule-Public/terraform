module "redis_security_group" {
  source = "git@github.com:Modern-Logic/terraform-modules.git//simple/vpc_security_group"
  environment         = var.environment
  company_name        = var.company_name
  tags                = var.tags
  security_group_name = "redis"
  vpc_id              = module.shared_vpc.vpc_id
  ingress_rules = [
    {
      description = "All traffic"
      from_port   = 6379
      to_port     = 6379
      protocol    = "tcp"
      cidr_block  = var.app_vpc_cidr
    }
  ]
}

module "redis" {
  source = "../src/modules/simple/redis"
  environment        = var.environment
  company_name       = var.company_name
  name               = "sls-redis"
  tags               = var.tags
  security_group_ids = [module.redis_security_group.security_group_id]
  subnet_ids         = module.shared_vpc.private_subnet_ids
  node_type          = var.redis_node_type
}
