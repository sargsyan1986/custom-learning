resource "aws_lb" "web" {
  name               = "WebServer-HA-ALB"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.webSG2.id]
  subnets            = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
}
