resource "aws_route53_zone" "zone" {
  count = var.deploy_route53 == true ? 1 : 0
  name  = var.zone_dns_name
}