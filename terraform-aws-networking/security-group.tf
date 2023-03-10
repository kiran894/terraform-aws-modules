/* NAT Security Group */
resource "aws_security_group" "nat_SG" {
  name        = "nat_SG"
  description = "Allow traffic for private subnets"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${local.tagName}-nagSG"
  }
}
resource "aws_security_group" "generalSG" {
  name        = "${var.environment}-general-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]
  tags = {
    Name        = "${local.tagName}-generalSG"
    Environment = "${var.environment}"
  }
}
resource "aws_security_group_rule" "ingress_rules" {
  count             = length(var.sg_ingress_rules)
  type              = "ingress"
  from_port         = var.sg_ingress_rules[count.index].from_port
  to_port           = var.sg_ingress_rules[count.index].to_port
  protocol          = var.sg_ingress_rules[count.index].protocol
  cidr_blocks       = [var.sg_ingress_rules[count.index].cidr_block]
  description       = var.sg_ingress_rules[count.index].description
  security_group_id = aws_security_group.generalSG.id
  depends_on        = [aws_security_group.generalSG]
}
/* db_security_group */
resource "aws_security_group" "DB_SG" {
  name        = "db_SG"
  description = "Allow traffic for db subnets"
  vpc_id      = aws_vpc.vpc.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.generalSG.id]
  }
  tags = {
    Name = "${local.tagName}-dbSG"
  }
}