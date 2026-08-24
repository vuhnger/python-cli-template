provider "github" {
  owner = var.owner
}

module "repository" {
  source = "./modules/github-repo"

  name        = var.name
  description = var.description
  visibility  = var.visibility
  topics      = var.topics

  required_status_checks = var.required_status_checks
  required_approvals     = var.required_approvals
}
