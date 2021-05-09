provider "google" {
  project = var.project
  region = var.region
}

data "google_project" "project" {
  project_id      = var.project
}

resource "google_project_service" "svcs" {
  for_each   = toset(["appengine", "cloudbuild", "cloudfunctions", "cloudscheduler"])
  project    = var.project
  service    = "${each.key}.googleapis.com"
}

module "watcher" {
  for_each = var.watchers

  source   = "./modules/watcher"
  project  = var.project
  pub_key  = var.pub_key
  priv_key = var.priv_key

  name              = each.key
  interval          = each.value.interval
  target_url        = each.value.target_url
  email             = each.value.email
  target_string     = each.value.target_string
  currently_present = each.value.currently_present

  depends_on = [
    google_project_service.svcs,
  ]
}
