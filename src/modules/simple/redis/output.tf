output "endpoint" {
  value = aws_elasticache_cluster.cluster.cache_nodes[0].address
}