output "cluster_address" {
  value = aws_elasticache_cluster.this.cluster_address
}

output "endpoint" {
  value = aws_elasticache_cluster.this.configuration_endpoint
}

output "cache_nodes" {
  value = aws_elasticache_cluster.this.cache_nodes
}