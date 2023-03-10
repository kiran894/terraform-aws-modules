/* Local declaration */
locals {
  tagName     = "${var.environment}-${var.product}-${var.service}"
  stackName   = "${var.environment}-${var.product}"
  az_names    = slice(data.aws_availability_zones.azs.names, 0, 3) // gives all az names in the region
  pub_sub_ids = aws_subnet.public_subnet.*.id                      // gives list of public subnet ids
  pri_sub_ids = aws_subnet.private_subnet.*.id
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "${local.tagName}"
    Environment = var.environment
  }
}







