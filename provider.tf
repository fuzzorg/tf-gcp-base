provider "google" {
  project = "fuzz-tf"
  region  = "us-east1"
}

provider "google-beta" {
  project = "fuzz-tf"
  region  = "us-east1"
}


provider "tfe" {}
