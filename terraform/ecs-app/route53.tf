module "web_route53_record" {
  count          = var.deploy_route53_resources == true ? length(local.web_route53_entries) : 0
  source = "git@github.com:Modern-Logic/terraform-modules.git//simple/route53_record"
  name           = local.web_route53_entries[count.index].subdomain
  zone_id        = local.web_route53_entries[count.index].id
  target         = module.shared_ecs_load_balancer.dns_name
  target_zone_id = module.shared_ecs_load_balancer.lb_hosted_zone
  tags           = var.tags
}

module "api_route53_record" {
  count          = var.deploy_route53_resources == true ? length(local.api_route53_entries) : 0
  source = "git@github.com:Modern-Logic/terraform-modules.git//simple/route53_record"
  name           = local.api_route53_entries[count.index].subdomain
  zone_id        = local.api_route53_entries[count.index].id
  target         = module.shared_ecs_load_balancer.dns_name
  target_zone_id = module.shared_ecs_load_balancer.lb_hosted_zone
  tags           = var.tags
}

module "grpc_record" {
  count          = var.deploy_route53_resources == true ? length(local.all_zone_ids) : 0
  source = "git@github.com:Modern-Logic/terraform-modules.git//simple/route53_record"
  name           = var.environment == "prod" ? "grpc" : "grpc-${var.environment}"
  zone_id        = local.all_zone_ids[count.index]
  target         = module.shared_ecs_load_balancer.dns_name
  target_zone_id = module.shared_ecs_load_balancer.lb_hosted_zone
  tags           = var.tags
}