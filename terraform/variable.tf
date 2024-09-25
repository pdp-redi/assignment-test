variable "project_name" {
  default = "node-app"
}

variable "env" {
  description = "demo-asg-alb-acm-route53"
  type        = string
  default     = "demo"
}

variable "region" {
  default = "ap-south-1"
}


variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "azs" {
  type        = list(string)
  description = "availability zones"
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "public subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "private subnet CIDR values"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "domain_name" {
  description = "domain_name"
  type        = string
  default     = "thepradeepreddy.in" #eg:domain
}

variable "ecr_repo" {
  type        = string
  description = "ECR repo name"
  default     = "my-ecr-repo"
}

variable "container" {
  type        = string
  description = "ECR container name"
  default     = "my-ecr-container"
}