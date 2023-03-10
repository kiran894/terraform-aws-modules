# /*=> vpc_id <=*/
output "vpc_id" {
  description = "vpc_id"
  value       = aws_vpc.vpc.id
}
output "vpc_cidr" {
  description = "vpc_cidr"
  value       = aws_vpc.vpc.cidr_block
}
output "cidr_dev" {
  description = "dev vpc_id"
  value       = var.environment == "dev" ? aws_vpc.vpc.cidr_block : ""
}

/*=> "List of IDs of subnets" <=*/
output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = local.pub_sub_ids
}
output "private_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = local.pri_sub_ids
}


output "aws_route_table_id_dev" {
  value = var.environment == "dev" ? aws_route_table.public_rt.id : ""
}
output "generalSG_id" {
  description = "Security group id"
  value       = aws_security_group.generalSG.id
}

