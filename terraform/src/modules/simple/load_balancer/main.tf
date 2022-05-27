resource "aws_lb" "load_balancer" {
  name               = substr("${var.load_balancer_name}-${var.company_name}-${var.environment}", 0, 32)
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    var.security_group_id
  ]
  idle_timeout = var.idle_timeout
  subnets      = var.subnets
  tags         = var.tags
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-2019-08"
  certificate_arn   = var.cert_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Please request a valid DNS name."
      status_code  = "200"
    }
  }
}
