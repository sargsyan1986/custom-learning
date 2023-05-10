data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

output "latest_ubun_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}

output "latest_ubun_ami_name" {
  value = data.aws_ami.latest_ubuntu.name
}


data "aws_ami" "latest_amazon" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023.0.*.0-kernel-6.1-x86_64"]
  }
}

output "latest_amazon_ami_id" {
  value = data.aws_ami.latest_amazon.id
}

output "latest_amazon_ami_name" {
  value = data.aws_ami.latest_amazon.name
}
