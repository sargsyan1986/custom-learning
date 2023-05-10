provider "aws" {
  region = "us-east-1"
}

resource "random_string" "rds_password" {
  length           = 12
  special          = true
  override_special = "!#$&"

  #   # ete uzum es vor amen angam henc ban poxvi , nor password generacni
  #   keepers = {
  #     keeper1    = var.name
  #     inchVorBan = var.something
  #  }
}

resource "aws_ssm_parameter" "rds_password" {
  name        = "/prod/mysql"
  description = "My password for MySQL"
  type        = "SecureString"
  value       = random_string.rds_password.result
}

# qani vor irakanum ayl texic enq vercnelu, dra hamar data
data "aws_ssm_parameter" "my_rds_passwd" {
  name = "/prod/mysql"

  # grum em depends , qani vor mek file-um em gtnvum ev resursstexcum
  # ayl depqerum chi grvum !!!
  depends_on = [aws_ssm_parameter.rds_password]
}

output "rds_passwd" {
  value     = data.aws_ssm_parameter.my_rds_passwd.value
  sensitive = true
}

resource "aws_db_instance" "imDB" {
  identifier           = "prod-rds"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "prod"
  username             = "administrator"
  password             = data.aws_ssm_parameter.my_rds_passwd.value
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  apply_immediately    = true
}
