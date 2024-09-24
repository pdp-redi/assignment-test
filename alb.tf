# create a application load balancer
resource "aws_lb" "alb" {
  name               = "${var.env}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public_subnets[*].id #[aws_subnet.public_subnets[*].id]
}

# target group for alb
resource "aws_lb_target_group" "alb_tg" {
  name        = "${var.env}-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
  health_check {
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 30
    interval            = 60
    matcher             = "200,301,302"
  }
}

#listener for alb
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.id
  }
  tags = {
    Name = "${var.env}-alb-listenter"
  }
}
