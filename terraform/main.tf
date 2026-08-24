provider "github" {
  owner = var.owner
}

module "repository" {
  source = "git::https://github.com/vuhnger/terraform-github-repo.git?ref=v1.0.0"

  name        = var.name
  description = var.description
  visibility  = var.visibility
  topics      = var.topics

  required_status_checks = var.required_status_checks
  required_approvals     = var.required_approvals
}
