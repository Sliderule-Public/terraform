module "database" {
  source      = "../src/modules/simple/cloud_sql_database_and_instance"
  app_name    = local.app_name
  environment = local.environment
  project_id  = module.google_project.project_id
  db_name     = "main"
  network_id  = module.compute_network.network_id
}