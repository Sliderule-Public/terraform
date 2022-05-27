module "web_task_definition" {
  source             = "../src/modules/simple/ecs_service_task_definition"
  environment        = var.environment
  image_tag          = var.environment == "prod" ? "master" : var.environment
  company_name       = var.company_name
  kms_key_arn        = module.main_key.key_arn
  account_id         = local.account_id
  container_port     = 8000
  memory             = 1024
  cpu                = 512
  image_name         = "shieldrule-web"
  task_name          = "${var.app_name}-web"
  region             = var.region
  execution_role_arn = module.ecs_task_execution_role.role_arn
  task_role_arn      = module.ecs_task_role.role_arn
  read_only          = false
  user               = "nginx"
  linuxParameters = {
    tmpfs = [{
      containerPath = "/var/cache/nginx"
      size          = 20
      mountOptions  = ["uid=101"]
    }]
  }
  environmentOverrides = [
    {
      name  = "foo",
      value = "bar"
    }
  ]
  tags = var.tags
}

module "api_task_definition" {
  source             = "../src/modules/simple/ecs_service_task_definition_api"
  environment        = var.environment
  image_tag          = var.environment
  company_name       = var.company_name
  kms_key_arn        = module.main_key.key_arn
  account_id         = local.account_id
  container_port     = 8000
  memory             = var.api_task_memory
  cpu                = var.api_task_vcpu
  image_name         = "shieldrule-api"
  task_name          = "${var.app_name}-api"
  region             = var.region
  execution_role_arn = module.ecs_task_execution_role.role_arn
  task_role_arn      = module.ecs_task_role.role_arn
  user               = "nobody"
  linuxParameters = {
    tmpfs = [{
      containerPath = "/tmp"
      size          = 20
      mountOptions  = []
    }]
  }
  environmentOverrides = [
    {
      name  = "ECS_ENABLE_CONTAINER_METADATA",
      value = "true"
    },
    {
      name  = "ENVIRONMENT",
      value = var.environment
    }
  ]
  environmentFiles = [
    {
      type : "s3",
      value : "${module.infrastructure_bucket.bucket_arn}/env-files/api/${var.environment}.env"
    }
  ]
  tags = var.tags
}

module "docs_task_definition" {
  source             = "../src/modules/simple/ecs_service_task_definition"
  environment        = var.environment
  image_tag          = var.environment == "prod" ? "dev" : var.environment
  company_name       = var.company_name
  kms_key_arn        = module.main_key.key_arn
  account_id         = local.account_id
  container_port     = 8000
  memory             = 256
  cpu                = 128
  image_name         = "shieldrule-docs"
  task_name          = "${var.app_name}-docs"
  region             = var.region
  execution_role_arn = module.ecs_task_execution_role.role_arn
  task_role_arn      = module.ecs_task_role.role_arn
  read_only          = false
  user               = "nginx"
  linuxParameters = {
    tmpfs = [{
      containerPath = "/var/cache/nginx"
      size          = 20
      mountOptions  = ["uid=101"]
    }]
  }
  environmentOverrides = [
    {
      name  = "foo",
      value = "bar"
    }
  ]
  tags = var.tags
}
