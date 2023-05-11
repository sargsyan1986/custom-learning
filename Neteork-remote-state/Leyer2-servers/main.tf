resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webSG.id]
  subnet_id              = data.terraform_remote_state.network.outputs.public_subnet_ids[0]
  user_data              = <<EOF
  #!/bin/bash
  yum -y update
  yum -y install httpd
  myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
  echo "<h2>Web Server with IP: $myip</h2><br>Build by TERRAFORM Remote State" > /var/www/html/index.html
  sudo service httpd start
  chkconfig httpd on
  EOF

  tags = {
    Name = "WebServer"
  }
}








resource "aws_security_group" "webSG" {
  name   = "Web Server Security Group"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.network.outputs.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "web-server-sg"
    Owner = "Hayko"
  }
}
