output "vpc_id" {
  value = aws_vpc.mainVPC.id
}

output "vpc_cidr" {
  value = aws_vpc.mainVPC.cidr_block
}

output "public_subnet_ids" {
  value = aws_subnet.subnets[*].id
}
