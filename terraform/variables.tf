variable "project" {
  description = "GCP project name"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "europe-west1-b"
}

variable "billing" {
  description = "GCP Billing Account Display Name"
  type        = string
}

variable "watchers" {
  description = "Watcher module variables"
  type = map(object({
    interval      = string
    name          = string
    target_url    = string
    email         = string
    target_string = string
  }))
}

variable "pub_key" {
  description = "Public MailJet API KEY"
  type        = string
}

variable "priv_key" {
  description = "Private MailJet API KEY"
  type        = string
}
