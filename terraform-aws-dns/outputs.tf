output "domain_name" {
  value = aws_route53_zone.this.name
  description = "value of the fully qualified domain name"
}