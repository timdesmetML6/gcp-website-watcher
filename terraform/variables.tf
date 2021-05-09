variable "project" {
  description = "GCP project name"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-west1"
}

variable "billing" {
  description = "GCP Billing Account Display Name"
  type        = string
}

variable "watchers" {
  description = "Watcher module variables"
  type = map(object({
    interval          = string
    target_url        = string
    email             = string
    target_string     = string
    currently_present = bool
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
