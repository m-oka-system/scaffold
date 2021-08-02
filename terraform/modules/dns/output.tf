output "hosted_zone_id" {
  value = aws_route53_zone.this.id
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.this.arn
}
