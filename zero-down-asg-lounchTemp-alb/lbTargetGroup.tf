resource "aws_lb_target_group" "web-tg" {
  name                 = "WebServer-HA-TG"
  vpc_id               = aws_default_vpc.default.id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 10 #sec
}
