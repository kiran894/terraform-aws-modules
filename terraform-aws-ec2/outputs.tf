/*-> aws_instance" "ec2" <-*/
output "ec2_instance_id" {
  description = "isntance id"
  value       = aws_instance.ec2.*.id
}
output "ec2_sg_id" {
  description = "security group id"
  value       = aws_security_group.ec2_SG.id
}