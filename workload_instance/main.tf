# Amazon Linux 2
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_security_group" "this" {
  name        = "workload-ec2"
  description = "Allow http inbound traffic"
  vpc_id      = var.vpc_id

  tags = merge(var.common_tags, {
    Name = "workload-ec2"
  })
}

resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  description       = "Allow all icmp"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  description       = "Allow all outbound"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}

resource "aws_instance" "this" {
  ami                  = data.aws_ami.amazon-linux-2.id
  instance_type        = "t3.micro"
  ebs_optimized        = false
  monitoring           = true
  key_name             = var.keypair_name
  subnet_id            = var.subnet_id
  iam_instance_profile = var.instance_profile
  # user_data                   = ""
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.this.id]

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
  }

  tags = merge(var.common_tags, {
    Name = "workload-ec2"
  })
}
