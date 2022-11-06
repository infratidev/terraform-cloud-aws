####################################################
# Create Certificate
####################################################

resource "aws_acm_certificate" "infracode-alb-certificate" {
  domain_name       = "${var.public_dns_hostname}.${var.public_dns_name}"
  validation_method = "DNS"
}

####################################################
# Create AWS Route 53 Certificate Validation Record in the Main Zone
####################################################

resource "aws_route53_record" "infracode-alb-certificate-validation-record" {
  for_each = {
    for infracode in aws_acm_certificate.infracode-alb-certificate.domain_validation_options : infracode.domain_name => {
      name   = infracode.resource_record_name
      record = infracode.resource_record_value
      type   = infracode.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.public-zone.zone_id
}

####################################################
# Create Certificate Validation
####################################################

resource "aws_acm_certificate_validation" "infracode-certificate-validation" {
  certificate_arn = aws_acm_certificate.infracode-alb-certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.infracode-alb-certificate-validation-record : record.fqdn]
}
