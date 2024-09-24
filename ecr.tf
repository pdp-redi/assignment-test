resource "aws_ecr_repository" "ecr_repo" {
  name                 = "node-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    "env" = "${var.env}-node-repo"
  }
}