
locals {
  admin_roles = [
    "roles/owner",
    "roles/resourcemanager.folderViewer",
    "roles/resourcemanager.projectCreator",
    "roles/compute.networkAdmin",
  ]
  folders = [
    "ops",
    "prod",
    "scratch"
  ]
}

resource "google_folder" "folders" {
  count        = length(local.folders)
  display_name = element(local.folders, count.index)
  parent       = var.google_organization
}
resource "google_folder_iam_member" "admins" {
  count  = length(local.folders) * length(local.admin_roles)
  folder = google_folder.folders[floor(count.index / length(local.admin_roles))].name
  role   = local.admin_roles[count.index % length(local.admin_roles)]

  member = var.admin_role
}
