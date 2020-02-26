resource "google_project" "project" {
  folder_id           = var.folder_id
  project_id          = var.name
  name                = var.name
  billing_account     = var.billing_account
  auto_create_network = false
  labels              = merge(var.labels,
  {
    managed_by = "terraform"
  })
}

resource "google_project_service" "project_services" {
  for_each                   = toset(var.activate_apis)
  project                    = google_project.project.project_id
  service                    = each.value
  disable_on_destroy         = true
  disable_dependent_services = true
}
