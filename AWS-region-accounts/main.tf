provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  region = "us-west-1"
  alias  = "WescCoast"
}

provider "aws" {
  region = "eu-central-1"
  alias  = "Germany"
}

data "aws_ami" "def_latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_ami" "west_latest_ubuntu" {
  provider    = aws.WescCoast
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_ami" "EU_latest_ubuntu" {
  provider    = aws.Germany
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "my_def_server" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.def_latest_ubuntu.id

  tags = {
    Name = "Def server"
  }
}

# Create ec2 in west region
resource "aws_instance" "my_def_server_West" {
  provider      = aws.WescCoast
  instance_type = "t2.micro"
  ami           = data.aws_ami.west_latest_ubuntu.id

  tags = {
    Name = "Def 2nd server"
  }
}

resource "aws_instance" "my_def_server_EU" {
  provider      = aws.Germany
  instance_type = "t2.micro"
  ami           = data.aws_ami.EU_latest_ubuntu.id

  tags = {
    Name = "Def 3nd server"
  }
}
