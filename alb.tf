####################################################
# Target Group Creation
####################################################

resource "aws_lb_target_group" "tg" {
  name        = "TargetGroup-InfraCode"
  port        = 80
  target_type = "instance"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.infracode_vpc.id
}

####################################################
# Target Group Attachment with Instance
####################################################

resource "aws_alb_target_group_attachment" "tgattachment" {
  count            = length(var.public_subnets_cidr)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = element(aws_instance.instance.*.id, count.index)
}

####################################################
# Application Load balancer
####################################################

resource "aws_lb" "lb-infracode" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id ]
  subnets            = aws_subnet.public_subnet.*.id
}

####################################################
# Listner
####################################################

resource "aws_lb_listener" "front_end" {
  depends_on = [
    aws_acm_certificate.infracode-alb-certificate,
    aws_route53_record.infracode-alb-certificate-validation-record,
    aws_acm_certificate_validation.infracode-certificate-validation
  ]

  load_balancer_arn = aws_lb.lb-infracode.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.infracode-alb-certificate.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

####################################################
# Listener Rule
####################################################

resource "aws_lb_listener_rule" "static" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn

  }

  condition {
    path_pattern {
      values = ["/var/www/html/index.html"]
    }
  }
}