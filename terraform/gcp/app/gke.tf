module "gke_cluster" {
  source      = "../src/modules/simple/gke"
  app_name    = local.app_name
  project_id  = module.google_project.project_id
  environment = local.environment
  location = local.region
}