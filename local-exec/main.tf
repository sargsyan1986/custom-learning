provider "aws" {
  region = "us-east-1"
}


resource "null_resource" "command" {
  provisioner "local-exec" {
    command = "echo Terraform Start: $(date) >> logs.txt"
  }
}

resource "null_resource" "command2" {
  provisioner "local-exec" {
    command = "ping -c 5 www.google.com"
  }
}

resource "null_resource" "command3" {
  provisioner "local-exec" {
    command     = "print('Barev World')"
    interpreter = ["python3", "-c"]
  }
}

resource "null_resource" "command4" {
  provisioner "local-exec" {
    command = "echo $NAME1 $NAME2 $NAME3 >> names.txt "
    environment = {
      NAME1 = "Valera"
      NAME2 = "Arev"
      NAME3 = "David"
    }
  }
}

resource "aws_instance" "imServer" {
  ami           = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  provisioner "local-exec" {
    command = "echo Barev from SUNNY Yerevan!"
  }
}

resource "null_resource" "command5" {
  provisioner "local-exec" {
    command = "echo Terraform End: $(date) >> logs.txt"
  }
  depends_on = [
    null_resource.command,
    null_resource.command2,
    null_resource.command3,
    null_resource.command4,
    aws_instance.imServer
  ]
}
