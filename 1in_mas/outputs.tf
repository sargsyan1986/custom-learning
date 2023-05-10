output "instance_id" {
  value = aws_instance.imec2.id
}

output "ec2_IP" {
  value = aws_instance.imec2.public_ip
}

output "SecGroup_ID" {
  value = aws_security_group.imSG_server.id
}

output "SecGroup_arn" {
  value = aws_security_group.imSG_server.arn
}

data "aws_availability_zones" "avzon" {}

output "data_aws_avzones" {
  value = data.aws_availability_zones.avzon.names
}

data "aws_caller_identity" "current" {}

output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

data "aws_region" "current" {}

output "data_aws_region_name" {
  value = data.aws_region.current.name
}

output "data_aws_region_description" {
  value = data.aws_region.current.description
}

data "aws_vpcs" "myVPCs" {}

output "aws_vpcs" {
  value = data.aws_vpcs.myVPCs.ids
}

data "aws_vpc" "customVPC" {
  tags = {
    Name = "ImAndznakanVPCn"
  }
}

output "customVPCid" {
  value = data.aws_vpc.customVPC.id
}

output "customVPCcidr" {
  value = data.aws_vpc.customVPC.cidr_block
}
