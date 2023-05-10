variable "env" {
  default = "dev" # t2.micro
  # default = "prod" # kstexcvi t2.large 
}

variable "prod_owner" {
  default = "Hayk Sargsyan"
}

variable "no_prod_owner" {
  default = "Yesim umn e"
}

variable "ec2_size" {
  default = {
    "prod"    = "t3.medium"
    "dev"     = "t3.micro"
    "staging" = "t2.small"
  }
}


variable "allow_port_list" {
  default = {
    "prod" = ["80", "443"]
    "dev"  = ["80", "443", "8080", "22"]
  }
}
