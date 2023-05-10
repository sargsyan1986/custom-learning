resource "aws_elb" "anun" {
  name               = "WebServer-HA-ELB"
  availability_zones = [data.aws_availability_zones.availZones.names[0], data.aws_availability_zones.availZones.names[1]]
  security_groups    = [aws_security_group.imSG_server.id]
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = 80
    instance_protocol = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 10
  }

  tags = {
    Name = "WebServer-HA-ELB"
  }
}
