module "vpc-project" {
  source          = "terraform-google-modules/project-factory/google"
  version         = "~> 6.0"
  org_id          = var.org_id
  billing_account = var.billing_account
  folder_id       = var.folder_id
  name            = "${var.name_prefix}-vpc"
  lien            = true
}

/******************************************
  Network Creation
 *****************************************/
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 2.1.0"

  project_id   = module.host-project.project_id
  network_name = "${var.name_prefix}-shared-vpc"

  delete_default_internet_gateway_routes = true
  shared_vpc_host                        = true

  subnets = [

  ]

  secondary_ranges = {

  }
}
