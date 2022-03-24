output "ecs_service" {
  value = {
    id = aws_ecs_service.this.id
  }
}