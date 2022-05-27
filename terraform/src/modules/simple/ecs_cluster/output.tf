output "cluster_id" {
  value = aws_ecs_cluster.foo.id
}
output "cluster_arn" {
  value = aws_ecs_cluster.foo.arn
}
output "capacity_provider_name" {
  value = aws_ecs_capacity_provider.provider.name
}
