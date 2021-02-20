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
    function      = string
    topic         = string
    scheduler     = string
    function_url  = string
    email         = string
    string_target = string
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
