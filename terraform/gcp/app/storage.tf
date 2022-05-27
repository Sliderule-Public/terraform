module "application_storage_bucket" {
  source      = "../src/modules/simple/storage_bucket"
  app_name    = local.app_name
  environment = local.environment
  project_id  = module.google_project.project_id
  bucket_name = "shieldrule-storage"
}