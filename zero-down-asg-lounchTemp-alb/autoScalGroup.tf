resource "aws_autoscaling_group" "web2ASG" {
  name                = "Web-HA-ASG-ver-${aws_launch_template.Web-lt.latest_version}"
  min_size            = 2
  max_size            = 2
  min_elb_capacity    = 2
  health_check_type   = "ELB"
  vpc_zone_identifier = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
  target_group_arns   = [aws_lb_target_group.web-tg.arn]

  launch_template {
    id      = aws_launch_template.Web-lt.id
    version = aws_launch_template.Web-lt.latest_version
  }

  dynamic "tag" {
    for_each = {
      Name   = "WebServer in ASG:v-${aws_launch_template.Web-lt.latest_version}"
      TAGKEY = "TAGVALUE"
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
