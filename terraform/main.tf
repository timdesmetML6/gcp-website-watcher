provider "google" {
  project = var.project
  region  = "europe-west1"
  zone    = "europe-west1-b"
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

resource "google_project_service" "scheduler_service" {
  service    = "cloudscheduler.googleapis.com"
  depends_on = [google_project.project]
}

resource "google_project_service" "functions_service" {
  service    = "cloudfunctions.googleapis.com"
  depends_on = [google_project.project]
}

resource "google_project_service" "build_service" {
  service    = "cloudbuild.googleapis.com"
  depends_on = [google_project.project]
}

resource "google_project_service" "appengine_service" {
  project    = var.project
  service    = "appengine.googleapis.com"
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

  interval      = each.value.interval
  function      = each.value.function
  topic         = each.value.topic
  scheduler     = each.value.scheduler
  function_url  = each.value.function_url
  email         = each.value.email
  string_target = each.value.string_target

  depends_on = [
    google_project.project,
    google_app_engine_application.app,
    google_project_service.scheduler_service,
    google_project_service.functions_service,
    google_project_service.build_service
  ]
}
