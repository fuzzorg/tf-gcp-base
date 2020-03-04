locals {
  project_name = "${var.name_prefix}-vpc"
}
resource "google_project" "vpc_project" {
  name                = local.project_name
  project_id          = local.project_name
  folder_id           = var.folder_id
  billing_account     = var.billing_account
  auto_create_network = false
  labels = {
    managed_by = "terraform"
  }
}

resource "google_project_service" "project" {
  project = google_project.vpc_project.project_id
  service = "compute.googleapis.com"

  disable_dependent_services = true
}

resource "google_compute_shared_vpc_host_project" "host" {
  project = google_project.vpc_project.project_id
}

resource "google_compute_network" "vpc_network" {
  name    = "fuzz-shared-vpc"
  project = google_project.vpc_project.project_id
}
