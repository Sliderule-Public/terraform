module "kms_key_main" {
  source      = "../src/modules/simple/kms_crypto_key"
  app_name    = local.app_name
  environment = local.environment
  project_id  = module.google_project.project_id
}