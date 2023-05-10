#  X = CONDITION ? VALUE_IF_TRUE : VALUE_IF_FALSE
#  instance_type = var.env == "prod" ? "t2.large" : "t2.micro"

provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "imWebServer" {
  ami           = "ami-007855ac798b5175e"
  instance_type = var.env == "prod" ? var.ec2_size["prod"] : var.ec2_size["dev"]
  #   instance_type = (var.env == "prod" ? "t2large" : "t2.micro")

  tags = {
    Name  = "${var.env}-server"
    Owner = var.env == "prod" ? var.prod_owner : var.no_prod_owner
  }
}

# create only for DEV !
resource "aws_instance" "im_dev_bastion" {
  count         = var.env == "dev" ? 1 : 0
  ami           = "ami-007855ac798b5175e"
  instance_type = "t2.micro"

  tags = {
    Name = "bastion-server-for-dev"
  }
}

resource "aws_instance" "webServer2" {
  ami           = "ami-007855ac798b5175e"
  instance_type = lookup(var.ec2_size, var.env)

  tags = {
    Name = "Web server 2"
  }
}

