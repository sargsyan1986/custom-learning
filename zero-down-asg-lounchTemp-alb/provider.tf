provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Owner     = "Hayk Sargsyan"
      CreatedBy = "Terraform"
    }
  }
}



