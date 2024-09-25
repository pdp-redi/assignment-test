# ECS Cluster
resource "aws_ecs_cluster" "my_cluster" {
  name = "my-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# Task Definition
resource "aws_ecs_task_definition" "my_task" {
  family                   = "my-task-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  #task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = var.container
      image = "816069142677.dkr.ecr.ap-south-1.amazonaws.com/my-ecr-repo" # Replace with your container image
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
}

# ECS Service
resource "aws_ecs_service" "my_service" {
  name            = "my-ecs-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  network_configuration {
    subnets = aws_subnet.private_subnets[*].id # Replace with your subnet IDs
    #assign_public_ip = true
    assign_public_ip = false                            # Set to false for private subnets
    security_groups  = [aws_security_group.ecs_task.id] # We'll define this security group
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.alb_tg.id
    container_port   = 8080
    container_name   = var.container
  }

  depends_on = [
    aws_ecr_repository.ecr_repo,
    aws_ecs_task_definition.my_task,
    aws_vpc.vpc,
    aws_lb_listener.alb_listener
  ]
}
