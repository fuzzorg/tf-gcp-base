locals {
  ids = zipmap(local.folders, slice(google_folder.folders[*].name, 0, length(local.folders)))
}

output "prod-folder" {
  value = local.ids["prod"]
}

output "ops-folder" {
  value = local.ids["ops"]
}
