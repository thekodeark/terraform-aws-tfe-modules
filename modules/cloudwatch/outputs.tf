output "log_group" {
  value = {
    name = aws_cloudwatch_log_group.this.name
    arn  = aws_cloudwatch_log_group.this.arn
  }
}

output "log_group_stream" {
  value = {
    name = aws_cloudwatch_log_stream.this.name
    arn  = aws_cloudwatch_log_stream.this.arn
  }
}