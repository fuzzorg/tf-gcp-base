module "vpc-project" {
  source          = "terraform-google-modules/project-factory/google"
  version         = "~> 5.0"
  org_id          = var.org_id
  billing_account = var.billing_account
  folder_id       = var.folder_id
  name            = "${var.name_prefix}-vpc"
  lien            = true
}
