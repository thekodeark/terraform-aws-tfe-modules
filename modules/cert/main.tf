data "aws_route53_zone" "this" {
  name         = "${var.hosted_zone}."
  private_zone = false
}

resource "aws_acm_certificate" "this" {
  domain_name       = var.fqdn
  validation_method = "DNS"

  tags = {
    Name = "${var.fqdn}-acm-certificate"
  }
  lifecycle {
    create_before_destroy = true
  }
}

# Route 53 Record
resource "aws_route53_record" "cert_validation" {
  name = lookup(local.dvo[0], "resource_record_name")
  records = [
    lookup(local.dvo[0], "resource_record_value")
  ]
  ttl     = 60
  type    = lookup(local.dvo[0], "resource_record_type")
  zone_id = data.aws_route53_zone.this.zone_id
  depends_on = [
    aws_acm_certificate.this
  ]
}

# Cert Validation
resource "aws_acm_certificate_validation" "this" {
  certificate_arn = element(aws_acm_certificate.this.*.arn, 0)

  validation_record_fqdns = [
    element(aws_route53_record.cert_validation.*.fqdn, 0)
  ]

  timeouts {
    create = "60m"
  }
}