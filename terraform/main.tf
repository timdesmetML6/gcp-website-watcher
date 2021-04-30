provider "google" {
  project = var.project
}

data "google_billing_account" "acct" {
  display_name = var.billing
  open         = true
}

resource "google_project" "project" {
  name            = var.project
  project_id      = var.project
  billing_account = data.google_billing_account.acct.id
}

resource "google_project_service" "svcs" {
  for_each = toset(["appengine", "cloudbuild", "cloudfunctions", "cloudscheduler"])
  project    = var.project
  service    = "${each.key}.googleapis.com"
  depends_on = [google_project.project]
}

resource "google_app_engine_application" "app" {
  project     = var.project
  location_id = "europe-west"
  depends_on  = [google_project_service.appengine_service]
}

module "watcher" {
  for_each = var.watchers

  source   = "./modules/watcher"
  project  = var.project
  pub_key  = var.pub_key
  priv_key = var.priv_key

  name          = each.key
  interval      = each.value.interval
  target_url    = each.value.target_url
  email         = each.value.email
  target_string = each.value.target_string

  depends_on = [
    google_project.project,
    google_app_engine_application.app,
    google_project_service.svcs,
  ]
}
