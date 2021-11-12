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

variable "backup_sp_id" {
  type        = string
  description = "Service principal ID used for backup"
}

variable "backup_sp_secret" {
  type        = string
  description = "Secret of the backup service principal"
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

variable "snapshots_enabled" {
  type        = bool
  description = "Enable Velero snapshots"
  default     = true
}

variable "velero_version" {
  type        = string
  description = "Velero Helm Chart version to use"
  default     = "2.26.3"
}

variable "azure_velero_plugin_version" {
  type        = string
  description = "Version of the azure velero plugin to use"
  default     = "v1.3.0"
}

variable "included_namespaces" {
  type        = list(string)
  description = "A list of namespaces to include in velero backup"
  default     = ["*"]
}

variable "excluded_namespaces" {
  type        = list(string)
  description = "A list of namespaces to exclude from velero backup"
  default = [
    "velero",
    "kube-system",
    "kube-public",
    "kube-node-lease"
  ]
}
