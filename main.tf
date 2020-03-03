data "google_organization" "org" {
  domain = var.gcp_organization_domain
}

data "google_billing_account" "acct" {
  display_name = var.gcp_billing_account
  open         = true
}

module "tf-project-services" {
  source                      = "terraform-google-modules/project-factory/google//modules/project_services"
  project_id                  = var.terraform_project
  disable_services_on_destroy = "true"

  activate_apis = var.terraform_project_services
}

module "root-folders" {
  source              = "./modules/root-folders"
  admin_role          = "group:infra-team@fuzz.app"
  google_organization = data.google_organization.org.name
}

module "prod-vpc" {
  source          = "./modules/vpc"
  name_prefix     = "fuzz"
  org_id          = data.google_organization.org.org_id
  billing_account = data.google_billing_account.acct.id
  folder_id       = module.root-folders.prod-folder
}

module "ops-workspace" {
  source                 = "./modules/tf-workspace-project"
  billing_account        = data.google_billing_account.acct.id
  folder_id              = module.root-folders.ops-folder
  project_prefix         = var.project_prefix
  terraform_organization = var.terraform_organization
  github_repo            = "fuzzorg/tf-ops"
  github_token           = var.github_token
}
