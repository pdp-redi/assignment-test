# security group for alb
resource "aws_security_group" "alb_sg" {
  name        = "${var.env}-alb-sg"
  description = "ALB Security Group"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS from Internet"
    from_port   = 443
    to_port     = 443
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
    Name = "${var.env}-alb-sg"
  }
}

# security group for ecs task
resource "aws_security_group" "ecs_task" {
  name        = "${var.env}-asg-security-group"
  description = "ASG Security Group"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env}-asg-sg"
  }
}