variable "nat_instance_type" {
  description = "NAT-Insance type to create nat instance"
}
variable "nat_ami" {
  description = "ami_id to be used to create nat-instance"
}
variable "environment" {
  type = string
  description = "name of the environment to be used"
}
variable "service" {
  type = string
  description = "name fo the service to be used"
}
variable "product" {
  type = string
  description = "name fo the product to be used"
}
variable "vpc_cidr" {
  type        = string
  description = "CIDR range for VPC"
  validation {
    condition     = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/16$", var.vpc_cidr))
    error_message = "Either invalid IP address or Cidr must be /16"
  }
}
variable "sg_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "Allowed HTTP Traffic for All"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "Allowed HTTPS Traffic for All"
    },
    {
      from_port   = 8443
      to_port     = 8443
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "Allowed Pritunal Traffic for All"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "122.160.234.6/32"
      description = "Allowed only for impressico primises"
    }
  ]
}
