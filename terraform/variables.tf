variable "owner" {
  description = "GitHub user or organisation that owns the repository"
  type        = string
  default     = "vuhnger"
}

variable "name" {
  description = "Repository name"
  type        = string
}

variable "description" {
  description = "One-line repository description"
  type        = string
}

variable "visibility" {
  description = "public or private"
  type        = string
  default     = "public"
}

variable "topics" {
  description = "Repository topics"
  type        = list(string)
  default     = []
}

variable "required_status_checks" {
  description = "Check names that must pass before a pull request can merge"
  type        = list(string)
  default     = ["test", "Conventional Commit title"]
}

variable "required_approvals" {
  description = "Approving reviews required before merge"
  type        = number
  default     = 0
}
