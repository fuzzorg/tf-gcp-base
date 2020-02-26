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
  source  = "terraform-google-modules/folders/google"
  version = "~> 2.0"

  parent = "${data.google_organization.org.name}"

  names = [
    "prod"
  ]

  set_roles = true

  per_folder_admins = [
    "group:infra-team@fuzz.app"
  ]

  all_folder_admins = [
  ]
}

module "prod-vpc" {
  source          = "./modules/vpc"
  name_prefix     = "fuzz"
  org_id          = "${data.google_organization.org.org_id}"
  billing_account = "${data.google_billing_account.acct.id}"
  folder_id       = "${module.root-folders.ids["prod"]}"
}
