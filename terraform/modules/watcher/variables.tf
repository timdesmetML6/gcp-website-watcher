variable "project" {
  description = "GCP project name"
  type        = string
}

variable "interval" {
  description = "Cronjob string"
  type        = string
}

variable "name" {
  description = "Main identifier for this watcher"
  type        = string
}

variable "target_url" {
  description = "URL to watch"
  type        = string
}

variable "target_string" {
  description = "String to watch for on page"
  type        = string
}

variable "pub_key" {
  description = "Public MailJet API KEY"
  type        = string
}

variable "priv_key" {
  description = "Private MailJet API KEY"
  type        = string
}

variable "email" {
  description = "Your email address"
  type        = string
}


variable "currently_present" {
  description = "If string is on the page currently"
  type        = bool
}
