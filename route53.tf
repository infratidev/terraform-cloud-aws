####################################################
# Reference to the Route 53 Main Public Zone
####################################################

data "aws_route53_zone" "public-zone" {  
  name         = var.public_dns_name
  private_zone = false
}

####################################################
# Create Route 53 A Record for the Load Balancer in the Main Zone
####################################################

resource "aws_route53_record" "infracode-alb-a-record" {
  depends_on = [aws_lb.lb-infracode]
  zone_id = data.aws_route53_zone.public-zone.zone_id
  name    = "${var.public_dns_hostname}.${var.public_dns_name}"
  type    = "A"
  alias {
    name                   = aws_lb.lb-infracode.dns_name
    zone_id                = aws_lb.lb-infracode.zone_id
    evaluate_target_health = true
  }
}