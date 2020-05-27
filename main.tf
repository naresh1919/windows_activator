provider "aws" {
  region = "ap-south-1"
}
# LoadBalancer creation
resource "aws_lb" "test" {
  name               = var.albname
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-0cd76560"]
  subnets            = ["subnet-a841c0e4", "subnet-8fce9ee7", "subnet-8a48aff1"]
  tags = {
    Name   = var.albname
    Role   = var.Role
    Vsad   = var.Vsad
    UserId = var.Userid
  }
}
# Target  Group1 creation
resource "aws_lb_target_group" "test" {
  name        = var.targetgroup
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "vpc-0c97bc64"
  target_type = "instance"
  health_check {
    enabled             = "true"
    healthy_threshold   = 3
    interval            = 15
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
  tags = {
    Name   = var.targetgroup
    Role   = var.Role
    Vsad   = var.Vsad
    UserId = var.Userid
  }
}
# target Group2 creation
resource "aws_lb_target_group" "test2" {
  name        = var.targetgrouptwo
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "vpc-0c97bc64"
  target_type = "instance"
  health_check {
    enabled             = "true"
    healthy_threshold   = 3
    interval            = 15
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
  tags = {
    Name   = var.targetgrouptwo
    Role   = var.Role
    Vsad   = var.Vsad
    UserId = var.Userid
  }
}
# Target Group3 creation
resource "aws_lb_target_group" "test3" {
  name        = var.targetgroupthree
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "vpc-0c97bc64"
  target_type = "instance"
  health_check {
    enabled             = "true"
    healthy_threshold   = 3
    interval            = 15
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
  tags = {
    Name   = var.targetgroupthree
    Role   = var.Role
    Vsad   = var.Vsad
    UserId = var.Userid
  }
}
# ALB default listener creation
resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"
  #  port              = "443"
  #  protocol          = "HTTPS"
  #  ssl_policy        = "ELBSecurityPolicy-2016-08"
  #  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}
# listener rule creation
resource "aws_lb_listener_rule" "static" {
  listener_arn = aws_lb_listener.test.arn
  priority     = 2

  action {
    type = "forward"
    # if varversion varible  is eqal to "test3" it add rule with targetgroup3, the values other than  "test2" it  connects to targetgroup2 
    target_group_arn = var.varversion == "test3" ? aws_lb_target_group.test3.arn : aws_lb_target_group.test2.arn
  }

  condition {
    path_pattern {
      values = ["/static/*"]
    }
  }
}
