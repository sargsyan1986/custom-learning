provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "imbucket789"
    key    = "dev/server/terraform.tfstate"
    region = "us-east-1"
  }
}
