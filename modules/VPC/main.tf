resource "aws_vpc" "VPC" {
  cidr_block           = var.VPC_CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.PROJECT_NAME}-vpc"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "${var.PROJECT_NAME}-igw"
  }
}

resource "aws_subnet" "PUBLIC" {
  count                   = length(var.PUBLIC_SUBNET_CIDRS)
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.PUBLIC_SUBNET_CIDRS[count.index]
  availability_zone       = var.AVAILABILITY_ZONES[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name                                      = "${var.PROJECT_NAME}-public-${count.index + 1}"
    "kubernetes.io/cluster/${var.EKS_CLUSTER_NAME}" = "shared"
    "kubernetes.io/role/elb"                  = "1"
  }
}

resource "aws_subnet" "PRIVATE" {
  count             = length(var.PRIVATE_SUBNET_CIDRS)
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.PRIVATE_SUBNET_CIDRS[count.index]
  availability_zone = var.AVAILABILITY_ZONES[count.index]

  tags = {
    Name                                           = "${var.PROJECT_NAME}-private-${count.index + 1}"
    "kubernetes.io/cluster/${var.EKS_CLUSTER_NAME}" = "shared"
    "kubernetes.io/role/internal-elb"              = "1"
  }
}

resource "aws_route_table" "PUBLIC" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "${var.PROJECT_NAME}-public-rt"
  }
}

resource "aws_route_table_association" "PUBLIC" {
  count          = length(aws_subnet.PUBLIC)
  subnet_id      = aws_subnet.PUBLIC[count.index].id
  route_table_id = aws_route_table.PUBLIC.id
}

resource "aws_eip" "NAT" {
  count  = var.ENABLE_NAT_GATEWAY ? 1 : 0
  domain = "vpc"

  tags = {
    Name = "${var.PROJECT_NAME}-nat-eip"
  }

  depends_on = [aws_internet_gateway.IGW]
}

resource "aws_nat_gateway" "NAT" {
  count         = var.ENABLE_NAT_GATEWAY ? 1 : 0
  allocation_id = aws_eip.NAT[0].id
  subnet_id     = aws_subnet.PUBLIC[0].id

  tags = {
    Name = "${var.PROJECT_NAME}-nat"
  }

  depends_on = [aws_internet_gateway.IGW]
}

resource "aws_route_table" "PRIVATE" {
  count  = var.ENABLE_NAT_GATEWAY ? 1 : 0
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT[0].id
  }

  tags = {
    Name = "${var.PROJECT_NAME}-private-rt"
  }
}

resource "aws_route_table_association" "PRIVATE" {
  count          = length(aws_subnet.PRIVATE)
  subnet_id      = aws_subnet.PRIVATE[count.index].id
  route_table_id = var.ENABLE_NAT_GATEWAY ? aws_route_table.PRIVATE[0].id : aws_route_table.PUBLIC.id
}

