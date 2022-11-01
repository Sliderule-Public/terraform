locals {
  web_task_count  = var.deploy_ecs == true ? var.desired_task_count_web : 0
  api_task_count  = var.deploy_ecs == true ? var.desired_task_count_api : 0
  jobs_task_count = var.deploy_ecs == true ? 1 : 0
}

module "services_ecs_cluster" {
  source = "git@github.com:Modern-Logic/terraform-modules.git//simple/ecs_cluster"
  environment           = var.environment
  company_name          = var.company_name
  cluster_name          = "services"
  autoscaling_group_arn = module.shared_ecs_auto_scaling_group.group_arn
  tags                  = var.tags
}

module "web_ecs_service" {
  count = var.deploy_ecs == true ? 1 : 0
  source = "git@github.com:Modern-Logic/terraform-modules.git//simple/ecs_service"
  environment             = var.environment
  company_name            = var.company_name
  service_name            = "${var.app_name}-web"
  host_listeners          = local.ecs_web_domains
  container_port          = 8000
  health_check_path       = "/"
  desired_count           = local.web_task_count
  container_to_forward_to = "${var.app_name}-web"
  capacity_provider_name  = module.services_ecs_cluster.capacity_provider_name
  cluster_id              = module.services_ecs_cluster.cluster_id
  listener_arn            = module.shared_ecs_load_balancer.listener_arn
  load_balancer_arn       = module.shared_ecs_load_balancer.lb_arn
  sns_arn                 = aws_sns_topic.alarms.arn
  task_definition_arn     = module.web_task_definition.task_definition_arn
  vpc_id                  = module.shared_vpc.vpc_id
  vpc_security_group_ids  = [module.shared_ecs_service_security_group.security_group_id]
  tags                    = var.tags
  subnets = [
    module.shared_vpc.private_subnet_id_0,
    module.shared_vpc.private_subnet_id_1,
  ]
}

module "api_ecs_service" {
  count = var.deploy_ecs == true ? 1 : 0
  source = "git@github.com:Modern-Logic/terraform-modules.git//simple/ecs_service_api"
  environment               = var.environment
  company_name              = var.company_name
  service_name              = "${var.app_name}-api"
  host_listeners            = local.ecs_api_domains
  container_port            = 8000
  health_check_path         = "/actuator/health"
  target_type               = "instance"
  desired_count             = local.api_task_count
  container_to_forward_to   = "${var.app_name}-api"
  capacity_provider_name    = module.services_ecs_cluster.capacity_provider_name
  cluster_id                = module.services_ecs_cluster.cluster_id
  listener_arn              = module.shared_ecs_load_balancer.listener_arn
  load_balancer_arn         = module.shared_ecs_load_balancer.lb_arn
  sns_arn                   = aws_sns_topic.alarms.arn
  task_definition_arn       = module.api_task_definition.task_definition_arn
  vpc_id                    = module.shared_vpc.vpc_id
  domain_names              = local.ecs_domains
  vpc_security_group_ids    = [module.shared_ecs_service_security_group.security_group_id]
  tags                      = var.tags
  api_health_check_interval = var.api_health_check_interval
  api_health_check_timeout  = var.api_health_check_timeout
  api_healthy_threshold     = var.api_healthy_threshold
  api_unhealthy_threshold   = var.api_unhealthy_threshold
  subnets = [
    module.shared_vpc.private_subnet_id_0,
    module.shared_vpc.private_subnet_id_1,
  ]
}

module "jobs_ecs_service" {
  count = var.deploy_ecs == true ? 1 : 0
  source = "git@github.com:Modern-Logic/terraform-modules.git//simple/ecs_service_no_route"
  environment             = var.environment
  company_name            = var.company_name
  service_name            = "${var.app_name}-jobs"
  container_port          = 8000
  health_check_path       = "/"
  desired_count           = local.jobs_task_count
  container_to_forward_to = "${var.app_name}-jobs"
  capacity_provider_name  = module.services_ecs_cluster.capacity_provider_name
  cluster_id              = module.services_ecs_cluster.cluster_id
  task_definition_arn     = module.jobs_task_definition.task_definition_arn
  vpc_id                  = module.shared_vpc.vpc_id
  vpc_security_group_ids  = [module.shared_ecs_service_security_group.security_group_id]
  tags                    = var.tags
  subnets = [
    module.shared_vpc.private_subnet_id_0,
    module.shared_vpc.private_subnet_id_1,
  ]
}

resource "aws_lb_listener_rule" "redirects" {
  count = var.deploy_ecs == true ? length(var.domains_to_redirect) : 0
  listener_arn = module.shared_ecs_load_balancer.listener_arn
  priority     = count.index + 10
  tags         = var.tags

  action {
    type = "redirect"

    redirect {
      host        = var.domains_to_redirect[count.index].to
      status_code = "HTTP_302"
    }
  }

  condition {
    host_header {
      values = [var.domains_to_redirect[count.index].from]
    }
  }
}
