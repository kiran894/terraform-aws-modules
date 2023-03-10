
variable "vpc_id" {
  description = "vpc_id in which resources to be created"
}
variable "iam_instance_profile_name" {
  type = string
  description = "iam instance profile name to assign to ec2 instance"
}
variable "instance_type" {
  type = string
  description = "type of the istance to use"
}
variable "ec2_ami" {
  description = "Name of the aws ami to create ec2 instance"
}
variable "region" {
  type = string
  description = "Name of the region in which resources to be created"
}
variable "environment" {
  type = string
  description = "Name of the environment"
}
variable "ec2_count" {}
variable "tags" {
  type        = map(string)
  description = "Name of the tags"
  default = {
    Name = "ec2_instance"
  }
}
variable "product" {
  description = "the product name"
  type        = string
}
variable "service" {
  description = "the service name"
  type        = string
}
variable "subnet_ids" {
  type = list(string)
}








