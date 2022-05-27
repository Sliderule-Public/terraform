resource "aws_route53_record" "record" {
  zone_id = var.zone_id
  name    = var.name
  type    = var.type
  alias {
    name                   = var.target
    zone_id                = var.target_zone_id
    evaluate_target_health = false
  }
}