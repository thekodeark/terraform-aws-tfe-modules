resource "aws_cloudwatch_log_group" "this" {
  name              = "${var.module_name}-${var.environment}-logs"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_stream" "this" {
  log_group_name = aws_cloudwatch_log_group.this.name
  name           = "${var.module_name}-${var.environment}-log-stream"
}