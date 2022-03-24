locals {
  dvo = flatten(aws_acm_certificate.this.*.domain_validation_options)
}