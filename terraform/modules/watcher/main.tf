resource "google_pubsub_topic" "trigger" {
  name = "watcher-${var.name}"
}

resource "google_cloud_scheduler_job" "watch-job" {
  name       = "watcher-${var.name}"
  schedule   = var.interval

  pubsub_target {
    topic_name = google_pubsub_topic.trigger.id
    data       = base64encode("Random message")
  }
}

resource "google_storage_bucket" "bucket" {
  name = "watcher-${var.name}"
}

resource "google_storage_bucket_object" "archive" {
  name   = "function.zip"
  bucket = google_storage_bucket.bucket.name
  source = "../function/function.zip"
}

resource "google_cloudfunctions_function" "function" {
  name        = "watcher-${var.name}"
  runtime     = "python37"
  entry_point = "hello_pubsub"

  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name

  event_trigger {
    event_type = "providers/cloud.pubsub/eventTypes/topic.publish"
    resource   = google_pubsub_topic.trigger.name
  }

  environment_variables = {
    URL        = var.target_url
    TARGET     = var.target_string
    PUBLIC_KEY = var.pub_key
    SECRET_KEY = var.priv_key
    EMAIL      = var.email
    CURRENTLY_PRESENT = var.currently_present
  }
}
