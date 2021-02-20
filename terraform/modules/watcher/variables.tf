variable "project" {
  description = "GCP project name"
  type        = string
}

variable "topic" {
  description = "GCP Topic"
  type        = string
}

variable "scheduler" {
  description = "GCP scheduler"
  type        = string
}

variable "interval" {
  description = "Cronjob string"
  type        = string
}

variable "function" {
  description = "GCP Cloud Function"
  type        = string
}

variable "function_url" {
  description = "URL to watch"
  type        = string
}

variable "string_target" {
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
