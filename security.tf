resource "aws_security_group" "ec2_security_group" {
  name        = "enable_ssh_http"
  description = "Habilitar SSH e HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "${var.environment}-ec2-security-group"
  }
}

resource "aws_security_group" "database-sec" {
  name        = "database-sec"
  description = "Allow MySQL inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "database-sec"
  }
}

resource "aws_security_group" "lb-sec" {
  name        = "lb-sec"
  description = "Allow LB inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "lb-sec"
  }
}

resource "aws_security_group_rule" "database-sec-rule" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.database-sec.id
  cidr_blocks       = [aws_vpc.main.cidr_block]
}

resource "aws_security_group_rule" "lb-sec-rule-ingress-http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.lb-sec.id
  cidr_blocks       = [aws_vpc.main.cidr_block]
}

resource "aws_security_group_rule" "lb-sec-rule-ingress-https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.lb-sec.id
  cidr_blocks       = [aws_vpc.main.cidr_block]
}

resource "aws_security_group_rule" "lb-sec-rule-egress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.lb-sec.id
  cidr_blocks       = ["0.0.0.0/0"]
}
