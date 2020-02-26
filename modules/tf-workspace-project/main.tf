locals {
  service_account_name = "tf-workspace-${var.name}"
}

resource "tfe_workspace" "app-workspace" {
  organization = var.terraform_organization
  name         = var.name
  vcs_repo {
    identifier     = var.github_repo
    oauth_token_id = var.github_token
  }
}

module "workspace_project" {
  source          = "../folder-project"
  folder_id       = var.folder_id
  billing_account = var.billing_account
  name            = "${var.project_prefix}-${var.name}"
  activate_apis   = var.activate_apis
  labels          = var.labels
}

module "service_accounts" {
  source          = "terraform-google-modules/service-accounts/google"
  version         = "~> 2.0"
  project_id      = module.workspace_project.project_id
  names           = [local.service_account_name]
  grant_xpn_roles = false
  generate_keys   = true
  project_roles = [
    "${module.workspace_project.project_id}=>roles/editor"
  ]
}

resource "tfe_variable" "google-creds" {
  workspace_id = tfe_workspace.app-workspace.id
  key          = "GOOGLE_CREDENTIALS"
  value        = replace(lookup(module.service_accounts.keys, local.service_account_name, "not-found"), "\n", "")
  category     = "env"
  sensitive    = true
}
