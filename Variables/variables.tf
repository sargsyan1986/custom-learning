variable "owner" {
  default = "Hayko"
}

variable "project" {
  default = "Instigator"
}

variable "envirorment" {
  default = "Dev"
}

locals {
  full_project_name = "${var.envirorment}-${var.project}"
  project_owner     = "${var.owner} is a owner of ${var.project} project "
}


variable "region" {
  description = "Please enter aws region, axperakan!" # Prompt
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Please enter aws ec2 type, axperakan!" # Prompt
  type        = string
  default     = "t2.micro"
}

variable "allow_ports" {
  description = "list of ports to open, axperakan!" # Prompt
  default     = ["80", "443", "22", "8080"]
  type        = list(any)
}

variable "monitor" {
  type    = bool
  default = false
}

variable "common-tags" {
  description = "common tags to add to all resources"
  type        = map(any)
  default = {
    Owner   = "Hayk Sargsyan"
    Project = "Instigator"
  }
}
