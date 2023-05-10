resource "aws_launch_configuration" "web" {
  # name            = "web_server_HiAv" # ays depqum popoxutyunner aneluc 2rd@ chi barcracni!
  name_prefix     = "web_server_HiAv"
  image_id        = data.aws_ami.latest_ubuntu.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.imSG_server.id]
  user_data       = file("script.sh")

  lifecycle {
    create_before_destroy = true
  }
}
