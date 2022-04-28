module "web_route53_record" {
  count          = var.deploy_route53_resources == true ? 1 : 0
  source         = "../src/modules/simple/route53_record"
  name           = local.web_subdomain
  zone_id        = var.zone_id
  target         = module.shared_ecs_load_balancer.dns_name
  target_zone_id = module.shared_ecs_load_balancer.lb_hosted_zone
  tags           = var.tags
}

module "api_route53_record" {
  count          = var.deploy_route53_resources == true ? 1 : 0
  source         = "../src/modules/simple/route53_record"
  name           = local.api_subdomain
  zone_id        = var.zone_id
  target         = module.shared_ecs_load_balancer.dns_name
  target_zone_id = module.shared_ecs_load_balancer.lb_hosted_zone
  tags           = var.tags
}

module "docs_route53_record" {
  count          = var.deploy_route53_resources == true ? 1 : 0
  source         = "../src/modules/simple/route53_record"
  name           = local.docs_subdomain
  zone_id        = var.zone_id
  target         = module.shared_ecs_load_balancer.dns_name
  target_zone_id = module.shared_ecs_load_balancer.lb_hosted_zone
  tags           = var.tags
}

module "grpc_record" {
  count          = var.deploy_route53_resources == true ? 1 : 0
  source         = "../src/modules/simple/route53_record"
  name           = var.environment == "prod" ? "grpc" : "grpc-${var.environment}"
  zone_id        = var.zone_id
  target         = module.shared_ecs_load_balancer.dns_name
  target_zone_id = module.shared_ecs_load_balancer.lb_hosted_zone
  tags           = var.tags
}