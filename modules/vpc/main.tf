resource "google_project" "vpc_project" {
  name                = "${var.name_prefix}-vpc"
  project_id          = "${var.name_prefix}-vpc"
  folder_id           = var.folder_id
  billing_account     = var.billing_account
  auto_create_network = false
}

resource "google_compute_shared_vpc_host_project" "host" {
  project = google_project.vpc_project.project_id
}
