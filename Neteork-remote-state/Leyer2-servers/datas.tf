data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "imbucket789"
    key    = "dev/network/terraform.tfstate"
    region = "us-east-1"
  }
}


data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


