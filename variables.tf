variable "gcp_organization_domain" {
  description = "The name of the gcp organization for all resources."
  default     = "fuzz.app"
}

variable "gcp_billing_account" {
  description = "The name of the billing account to associate with projects."
  default     = "My Billing Account"
}

variable "terraform_project" {
  description = "The project id for the already-created terraform project"
  default     = "fuzz-tf"
}

variable "terraform_project_services" {
  description = "Service APIs enabled by default in new projects."
  default = [
    "compute.googleapis.com",
    "serviceusage.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com",
    "stackdriver.googleapis.com",
  ]
}
