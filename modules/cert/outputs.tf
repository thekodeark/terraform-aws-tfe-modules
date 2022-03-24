output "arn" {
  value = aws_acm_certificate.this.arn
}

output "zone_id" {
  value = data.aws_route53_zone.this.zone_id
}