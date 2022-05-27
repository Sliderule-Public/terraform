module "compute_network" {
  source      = "../src/modules/simple/compute_network"
  app_name    = local.app_name
  environment = local.environment
  project_id  = module.google_project.project_id
}