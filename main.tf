data "google_organization" "org" {
  domain = "fuzz.app"
}

data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}

module "tf-project-services" {
  source                      = "terraform-google-modules/project-factory/google/modules/project-services"
  project_id                  = var.terraform_project
  enable_apis                 = var.enable
  disable_services_on_destroy = "true"

  activate_apis = [
  ]
}

###############################################################################
#                              Audit log exports                              #
###############################################################################

# audit logs project

module "project-audit" {
  source          = "terraform-google-modules/project-factory/google"
  version         = "~> 7.0"
  parent          = "${data.google_organization.org.name}"
  billing_account = "${data.google_billing_account.acct.id}"
  name            = "audit"
  lien_reason     = "audit"
  activate_apis = concat(var.project_services, [
    "bigquery.googleapis.com",
  ])
  viewers = var.audit_viewers
}

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
