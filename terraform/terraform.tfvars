region               = "ap-south-1"
env                  = "arsipa-challenge"
azs                  = ["ap-south-1a", "ap-south-1b"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
vpc_cidr             = "10.0.0.0/16"
domain_name          = "thepradeepreddy.in"
container_port       = "8080"
host_port            = "8080"
fargate_cpu          = "256"
fargate_memory       = "512"