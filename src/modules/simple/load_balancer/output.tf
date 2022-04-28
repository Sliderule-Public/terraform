output "listener_arn" {
  value = aws_lb_listener.https.arn
}
output "dns_name" {
  value = aws_lb.load_balancer.dns_name
}
output "lb_hosted_zone" {
  value = aws_lb.load_balancer.zone_id
}
output "lb_arn" {
  value = aws_lb.load_balancer.arn
}
