resource "aws_security_group" "alb_sg" {
    vpc_id = "${var.vpc_id}"
    name = "ALB-SG"
    description = "allow web public access"
    tags = {
        Name = "ALB-SG"
    }
}

resource "aws_security_group" "ec2_sg" {
    vpc_id = "${var.vpc_id}"
    name = "EC2-SG"
    description = "allow alb access"
    tags = {
        Name = "EC2-SG"
    }
}

resource "aws_vpc_security_group_ingress_rule" "alb_ib_rule" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_egress_rule" "alb_ob_rule" {
  security_group_id = aws_security_group.alb_sg.id
  referenced_security_group_id = aws_security_group.ec2_sg.id
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "ec2_ib_rule" {
  security_group_id = aws_security_group.ec2_sg.id
  referenced_security_group_id = aws_security_group.alb_sg.id
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_egress_rule" "ec2_ob_rule" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}