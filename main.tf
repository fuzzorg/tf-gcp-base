data "google_organization" "org" {
  domain = "fuzz.app"
}

data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}

module "tf-project-services" {
  source                      = "terraform-google-modules/project-factory/google//modules/project_services"
  project_id                  = var.terraform_project
  disable_services_on_destroy = "true"

  activate_apis = var.project_services
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

###############################################################################
#                              Audit log exports                              #
###############################################################################

# audit logs project
# module "project-audit" {
#   source          = "./modules/audit"
#   org_id          = "${data.google_organization.org.org_id}"
#   billing_account = "${data.google_billing_account.acct.id}"
#   name            = "fuzz-audit"
# }


# audit logs destination on BigQuery

# module "bq-audit-export" {
#   source                   = "terraform-google-modules/log-export/google//modules/bigquery"
#   version                  = "~> 4.0"
#   project_id               = module.project-audit.project_id
#   dataset_name             = "logs_audit_${replace(var.environments[0], "-", "_")}"
#   log_sink_writer_identity = module.log-sink-audit.writer_identity
# }

# # audit log sink
# # set the organization as parent to export audit logs for all environments

# module "log-sink-audit" {
#   source                 = "terraform-google-modules/log-export/google"
#   version                = "~> 4.0"
#   filter                 = var.audit_filter
#   log_sink_name          = "logs-audit-${var.environments[0]}"
#   parent_resource_type   = "folder"
#   parent_resource_id     = split("/", module.folders-top-level.ids_list[0])[1]
#   include_children       = "true"
#   unique_writer_identity = "true"
#   destination_uri        = "${module.bq-audit-export.destination_uri}"
# }
