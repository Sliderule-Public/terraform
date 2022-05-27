module "api_artifact_repo" {
  source      = "../src/modules/simple/artifact_registry_repository"
  app_name    = local.app_name
  image_name  = "api"
  project_id  = module.google_project.project_id
  environment = local.environment
}

module "docs_artifact_repo" {
  source      = "../src/modules/simple/artifact_registry_repository"
  app_name    = local.app_name
  image_name  = "docs"
  project_id  = module.google_project.project_id
  environment = local.environment
}

module "web_artifact_repo" {
  source      = "../src/modules/simple/artifact_registry_repository"
  app_name    = local.app_name
  image_name  = "web"
  project_id  = module.google_project.project_id
  environment = local.environment
}