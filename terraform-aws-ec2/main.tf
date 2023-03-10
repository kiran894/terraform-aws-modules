locals {
  env_tag = {
    Environment = "var.environment"
  }
  web_tags = merge(var.tags, local.env_tag)
}
resource "aws_instance" "ec2" {
  count                       = var.ec2_count
  ami                         = var.ec2_ami[var.region]
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_ids[count.index]
  vpc_security_group_ids      = [aws_security_group.ec2_SG.id]
  key_name                    = "LaptopKey"
  associate_public_ip_address = true
  user_data                   = file("${path.module}/scripts/userdata.sh")
  //iam_instance_profile        = var.iam_instance_profile_name // to assign iam role to ec2 instance
  tags = local.web_tags
}

resource "aws_security_group" "ec2_SG" {
  name        = "ec2_SG"
  description = "Allow traffic for ec2 server"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.environment}-ec2SG"
  }
}

