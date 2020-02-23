data "google_organization" "org" {
  domain = "fuzz.app"
}

data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}
