resource "aws_launch_template" "Web-lt" {
  name                   = "Web-HA-LT"
  image_id               = data.aws_ami.latest_ubuntu.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webSG2.id]
  user_data              = filebase64("script.sh")
}
