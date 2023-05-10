resource "aws_subnet" "customSubnet_1" {
  vpc_id            = data.aws_vpc.customVPC.id
  availability_zone = data.aws_availability_zones.avzon.names[0]
  cidr_block        = "10.10.1.0/24"
  tags = {
    Name    = "Subnet-1 in ${data.aws_availability_zones.avzon.names[0]}"
    Account = "Subnet in accaunt ${data.aws_caller_identity.current.account_id}"
    Region  = data.aws_region.current.description
  }
}

resource "aws_subnet" "customSubnet_2" {
  vpc_id            = data.aws_vpc.customVPC.id
  availability_zone = data.aws_availability_zones.avzon.names[1]
  cidr_block        = "10.10.2.0/24"
  tags = {
    Name    = "Subnet-2 in ${data.aws_availability_zones.avzon.names[1]}"
    Account = "Subnet in accaunt ${data.aws_caller_identity.current.account_id}"
    Region  = data.aws_region.current.description
  }
}
