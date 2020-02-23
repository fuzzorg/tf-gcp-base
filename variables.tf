variable "audit_viewers" {
  description = "Audit project viewers, in IAM format."
  default = [
  ]
}

variable "terraform_project" {
  description = "The project id for the already-created terraform project"
  default     = "fuzz-tf"
}

variable "project_services" {
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
