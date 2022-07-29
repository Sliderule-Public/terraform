module "main_pub_sub_topic" {
  source      = "../src/modules/simple/pub_sub"
  app_name    = local.app_name
  environment = local.environment
  topic_name  = "main"
  project_id  = module.google_project.project_id
}