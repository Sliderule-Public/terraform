resource "aws_ecr_repository" "web" {
  count                = var.deploy_ecr_repositories == true ? 1 : 0
  name                 = "shieldrule-web"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "api" {
  count                = var.deploy_ecr_repositories == true ? 1 : 0
  name                 = "shieldrule-api"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "docs" {
  count                = var.deploy_ecr_repositories == true ? 1 : 0
  name                 = "shieldrule-docs"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "prometheus" {
  count                = var.deploy_ecr_repositories == true ? 1 : 0
  name                 = "prometheus"
  image_tag_mutability = "MUTABLE"
}