provider "aws" {
  region = "us-east-1"
}

variable "aws_users" {
  description = "list of IAM users"
  default = [
    "Davit",
    "Valera",
    "Arev",
    "Roksi",
    "Areg",
    "Hayk"
  ]

}

resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index) # count.index@ hashvum e !
}


output "created_iam_users" {
  value = aws_iam_user.users
}

output "created_iam_users_ids" {
  value = aws_iam_user.users[*].id
}

# exemple : "Username : Hayk has ARN arn:aws:iam::735481326586:user/Hayk"
output "created_iam_users_custom" {
  value = [
    for user in aws_iam_user.users : # FOR I IN [ARRAY]
    "Username : ${user.name} has ARN ${user.arn}"
  ]
}

output "created_iam_users_map" {
  value = {
    for user in aws_iam_user.users :
    user.unique_id => user.id # exemple : AIDA2WPQ2NP5A5A5NP2ED = "Hayk"
  }
}

# print list of users with 5 characters
output "custom_if_lenght" {
  value = [
    for x in aws_iam_user.users :
    x.name
    if length(x.name) == 5
  ]
}


resource "aws_instance" "servers" {
  ami           = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  count         = 3

  tags = {
    Name = "Server Number - ${count.index + 1}"
  }
}

output "server_all" {
  value = {
    for server in aws_instance.servers :
    server.id => server.public_ip
  }

}

