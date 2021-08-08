################################
# ELB
################################
resource "aws_lb" "this" {
  name                       = "${var.env}-${var.project}-alb"
  load_balancer_type         = "application"
  internal                   = false
  idle_timeout               = 60
  enable_deletion_protection = false

  subnets = aws_subnet.public.*.id

  security_groups = [
    aws_security_group.elb.id
  ]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      protocol    = "HTTPS"
      port        = "443"
      host        = "#{host}"
      path        = "/#{path}"
      query       = "#{query}"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.acm_certificate_arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
  name                 = "${var.env}-${var.project}-alb-tg"
  target_type          = "ip"
  vpc_id               = aws_vpc.vpc.id
  port                 = 3000
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    protocol            = "HTTP"
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = 200
  }

  depends_on = [aws_lb.this]
}

################################
# Route 53 (Alias record)
################################
resource "aws_route53_record" "this" {
  name    = "${var.env}.${var.my_domain}"
  zone_id = var.hosted_zone_id
  type    = "A"

  alias {
    name                   = aws_lb.this.dns_name
    zone_id                = aws_lb.this.zone_id
    evaluate_target_health = true
  }
}
