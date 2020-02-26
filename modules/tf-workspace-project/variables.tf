variable "name" {
  default     = "ops"
  description = "The basename of the project for TF workspaces and Github. Will be prefixed with project-prefix"
}

variable "billing_account" {
    description = "The billing account to associate with this project"
}

variable "labels" {
    description = "Additional labels to place on the project. managed-by: terraform will be automatically applied"
    type        = map(string)
    default     = {}
}

variable "activate_apis" {
    description = "APIs to activate for the project"
    default = []
}

variable "folder_id" {
    description = "the parent folder id to create this project into"
}

variable "project_prefix" {
  description = "An identifier to prefix with the name"
}

variable terraform_organization {
  description = "The terraform cloud organization name"
}

variable github_repo {
  description = "The name of the github repo to store ops files"
}

variable github_token {
  description = "The oauth token established between TF Cloud and Github for VCS integration"
}
