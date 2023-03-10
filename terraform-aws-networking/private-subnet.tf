/* Private subnet */
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(local.az_names)
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + 101)
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.environment}-${element(local.az_names, count.index)}-private-subnet"
    Environment = "${var.environment}"
  }
}
/* NAT instance */
resource "aws_instance" "nat_instance" {
  ami                    = var.nat_ami
  instance_type          = var.nat_instance_type
  subnet_id              = local.pub_sub_ids[0]
  source_dest_check      = false
  vpc_security_group_ids = [aws_security_group.nat_SG.id]

  tags = {
    Name        = "${local.tagName}-nat-instance"
    Environment = var.environment
  }
}
/* Routing table for private subnet */
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.nat_instance.id
  }
  tags = {
    Name = "${local.tagName}-private-route-table"
  }
}
/* Route table associations with private subnets*/
resource "aws_route_table_association" "private" {
  count          = length(local.az_names)
  subnet_id      = local.pri_sub_ids[count.index]
  route_table_id = aws_route_table.private_rt.id
}