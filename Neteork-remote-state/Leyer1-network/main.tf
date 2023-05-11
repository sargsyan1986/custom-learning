resource "aws_vpc" "mainVPC" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_subnet" "subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.mainVPC.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.avalable.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}-public-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "mainIGW" {
  vpc_id = aws_vpc.mainVPC.id

  tags = {
    Name = "${var.env}-igw"
  }
}

resource "aws_route_table" "public_subnets" {
  vpc_id = aws_vpc.mainVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mainIGW.id
  }
  tags = {
    Name = "${var.env}-route-public-subnets"
  }
}

resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.subnets[*].id)
  route_table_id = aws_route_table.public_subnets.id
  subnet_id      = element(aws_subnet.subnets[*].id, count.index)
}

