resource "aws_lb" "front_end" {
  name               = "front-end"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb-sec.id]
  subnets            = aws_subnet.public[*].id

  enable_deletion_protection = true

  tags = {
    Name        = "front-end"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "main" {
  name        = "front-end-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}


resource "aws_lb_target_group_attachment" "front_end" {
  for_each         = { for instance in aws_instance.machine_ec2 : instance.id => instance }
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = each.value.id
  port             = 80
}
