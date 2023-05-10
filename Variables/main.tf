provider "aws" {
  region = var.region
}


data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "Ec2" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ASGEc2.id]
  monitoring             = var.monitor

  # tags = merge(var.common-tags,{ Name="server4"})
  tags = {
    Name          = "Server4"
    Owner         = "Hayko"
    project_owner = local.project_owner
  }
}

resource "aws_security_group" "ASGEc2" {
  name = "mySG"

  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #   tags = {
  #     Name = "Web sec group"
  #   }
  #   tags = var.common-tags

  tags = merge(var.common-tags, { Name = "Web sec group" })
}
