output "cluster" {
  value = {
    id   = aws_ecs_cluster.this.id
    arn  = aws_ecs_cluster.this.arn
    name = aws_ecs_cluster.this.name
  }
}