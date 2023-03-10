/* Public subnet  */
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(local.az_names)
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + 1)
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.environment}-${element(local.az_names, count.index)}- public-subnet"
    Environment = "${var.environment}"
  }
}

/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${local.tagName}-igw"
    Environment = "${var.environment}"
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    Name        = "${local.tagName}-public-route-table"
    Environment = "${var.environment}"
  }
}
/* Route table associations with public subnets*/
resource "aws_route_table_association" "public" {
  count          = length(local.az_names)
  subnet_id      = local.pub_sub_ids[count.index]
  route_table_id = aws_route_table.public_rt.id
}

