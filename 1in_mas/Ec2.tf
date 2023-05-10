resource "aws_instance" "imec2" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.imSG_server.id]
  user_data              = file("script.sh") # or tamplatefile("script.sh.tpl")

  tags = {
    Name = "Web server"
  }

  lifecycle {
    # ignore_changes = ["ami", "user_data"] # terminate chi ani ec2@ erb ban poxvi, IGNOR
    # prevent_destroy = true # defoult is false
    create_before_destroy = true
  }
}
