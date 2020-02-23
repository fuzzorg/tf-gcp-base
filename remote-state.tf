terraform {
  backend "remote" {
    organization = "fuzz"

    workspaces {
      prefix = "tf-"
    }
  }
}
