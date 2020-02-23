module "project-audit" {
  source          = "terraform-google-modules/project-factory/google"
  version         = "~> 6.0"
  org_id          = var.org_id
  billing_account = var.billing_account
  name            = var.name
  lien            = true
}
