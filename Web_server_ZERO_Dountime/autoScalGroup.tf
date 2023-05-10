resource "aws_autoscaling_group" "webASG" {
  name                 = "${aws_launch_configuration.web.name}-ASG"
  launch_configuration = aws_launch_configuration.web.name
  min_size             = 2
  max_size             = 2
  min_elb_capacity     = 2
  vpc_zone_identifier  = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
  health_check_type    = "ELB"
  load_balancers       = [aws_elb.anun.name]

  dynamic "tag" {
    for_each = {
      Name  = "WebServer-in-ASG"
      Owner = "Hayk Sargsyan"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

