variable "project" {
  type        = string
  description = "Three letter project key"
}

variable "stage" {
  type        = string
  description = "Stage for this ip"
}

variable "location" {
  type        = string
  description = "Azure location to use for the backup"
}

variable "subscription_id" {
  type        = string
  description = "The Subscription ID to use"
}

variable "resource_group" {
  type        = string
  description = "Azure Resource Group to use"
}

variable "backup_application_id" {
  type        = string
  description = "Application ID used for backup"
}

variable "backup_application_secret" {
  type        = string
  description = "Secret of the backup application"
}

variable "backup_tenant_id" {
  type        = string
  description = "Tenant ID of the backup application"
}

variable "schedule" {
  type        = string
  description = "Schedule for the cronjob"
  default     = "0 0 * * *"
}

variable "ttl" {
  type        = string
  description = "Time to live for the backup in form of <x>h<x>m<x>s (example for 14 days: 336h0m0s)"
  default     = "336h0m0s"
}
