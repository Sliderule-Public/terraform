module "services_ecs_cluster" {
  source                = "../src/modules/simple/ecs_cluster"
  environment           = var.environment
  company_name          = var.company_name
  cluster_name          = "services"
  autoscaling_group_arn = module.shared_ecs_auto_scaling_group.group_arn
  tags                  = var.tags
}

module "web_ecs_service" {
  source                  = "../src/modules/simple/ecs_service"
  environment             = var.environment
  company_name            = var.company_name
  service_name            = "${var.app_name}-web"
  subdomain               = local.web_subdomain
  host_listeners          = length(var.web_host_listeners) > 0 ? var.web_host_listeners : [local.formatted_web_hostname]
  container_port          = 8000
  health_check_path       = "/"
  desired_count           = var.desired_task_count_web
  container_to_forward_to = "${var.app_name}-web"
  capacity_provider_name  = module.services_ecs_cluster.capacity_provider_name
  cluster_id              = module.services_ecs_cluster.cluster_id
  listener_arn            = module.shared_ecs_load_balancer.listener_arn
  load_balancer_arn       = module.shared_ecs_load_balancer.lb_arn
  sns_arn                 = aws_sns_topic.alarms.arn
  task_definition_arn     = module.web_task_definition.task_definition_arn
  vpc_id                  = module.shared_vpc.vpc_id
  domain                  = var.domain
  vpc_security_group_ids  = [module.shared_ecs_service_security_group.security_group_id]
  tags                    = var.tags
  subnets = [
    module.shared_vpc.private_subnet_id_0,
    module.shared_vpc.private_subnet_id_1,
  ]
}

module "api_ecs_service" {
  source                  = "../src/modules/simple/ecs_service_api"
  environment             = var.environment
  company_name            = var.company_name
  service_name            = "${var.app_name}-api"
  subdomain               = local.api_subdomain
  host_listeners          = length(var.api_host_listeners) > 0 ? var.api_host_listeners : [local.formatted_api_hostname]
  container_port          = 8000
  health_check_path       = "/actuator/health"
  target_type             = "instance"
  desired_count           = var.desired_task_count_api
  container_to_forward_to = "${var.app_name}-api"
  capacity_provider_name  = module.services_ecs_cluster.capacity_provider_name
  cluster_id              = module.services_ecs_cluster.cluster_id
  listener_arn            = module.shared_ecs_load_balancer.listener_arn
  load_balancer_arn       = module.shared_ecs_load_balancer.lb_arn
  sns_arn                 = aws_sns_topic.alarms.arn
  task_definition_arn     = module.api_task_definition.task_definition_arn
  vpc_id                  = module.shared_vpc.vpc_id
  domain                  = var.domain
  vpc_security_group_ids  = [module.shared_ecs_service_security_group.security_group_id]
  tags                    = var.tags
  subnets = [
    module.shared_vpc.private_subnet_id_0,
    module.shared_vpc.private_subnet_id_1,
  ]
}

module "docs_ecs_service" {
  source                  = "../src/modules/simple/ecs_service"
  environment             = var.environment
  company_name            = var.company_name
  service_name            = "${var.app_name}-docs"
  subdomain               = local.docs_subdomain
  host_listeners          = length(var.docs_host_listeners) > 0 ? var.docs_host_listeners : [local.formatted_docs_hostname]
  container_port          = 8000
  health_check_path       = "/"
  desired_count           = var.desired_task_count_docs
  container_to_forward_to = "${var.app_name}-docs"
  capacity_provider_name  = module.services_ecs_cluster.capacity_provider_name
  cluster_id              = module.services_ecs_cluster.cluster_id
  listener_arn            = module.shared_ecs_load_balancer.listener_arn
  load_balancer_arn       = module.shared_ecs_load_balancer.lb_arn
  sns_arn                 = aws_sns_topic.alarms.arn
  task_definition_arn     = module.docs_task_definition.task_definition_arn
  vpc_id                  = module.shared_vpc.vpc_id
  domain                  = var.domain
  vpc_security_group_ids  = [module.shared_ecs_service_security_group.security_group_id]
  tags                    = var.tags
  subnets = [
    module.shared_vpc.private_subnet_id_0,
    module.shared_vpc.private_subnet_id_1,
  ]
}
