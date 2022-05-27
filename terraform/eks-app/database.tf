module "rds_instance" {
  source              = "../src/modules/simple/rds"
  environment         = var.environment
  company_name        = var.company_name
  region              = var.region
  cluster_name        = "services"
  availability_zone   = local.database_az
  role_arn            = module.rds_role.role_arn
  security_group      = module.rds_security_group.security_group_id
  private_subnets     = local.private_subnet_ids
  public_subnets      = local.public_subnet_ids
  tags                = var.tags
  kms_key_arn         = module.rds_key.key_arn
  initial_database    = var.initial_database
  master_password     = var.master_db_password
  master_username     = var.master_db_username
  snapshot_identifier = var.snapshot_identifier != "" ? var.snapshot_identifier : ""
  skip_final_snapshot = var.skip_final_snapshot
  deploy_read_replica = var.deploy_read_replica
}
