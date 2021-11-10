# Terraform managemen of velero backup on AKS

## Introduction

This module manages velero backup on AKS (Azure Kubernetes Service)

## Usage

Instantiate the module by calling it from Terraform like this:

```hcl
module "azure-basics" {
  source  = "dodevops/backup/azure"
  version = "<version>"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

The following providers are used by this module:

- azurerm

- helm

- kubernetes

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azurerm_storage_account.storaccbackup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) (resource)
- [azurerm_storage_container.storcontbackup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) (resource)
- [helm_release.velero](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) (resource)
- [kubernetes_namespace.velero](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) (resource)

## Required Inputs

The following input variables are required:

### backup\_application\_id

Description: Application ID used for backup

Type: `string`

### backup\_application\_secret

Description: Secret of the backup application

Type: `string`

### backup\_tenant\_id

Description: Tenant ID of the backup application

Type: `string`

### location

Description: Azure location to use for the backup

Type: `string`

### project

Description: Three letter project key

Type: `string`

### resource\_group

Description: Azure Resource Group to use

Type: `string`

### stage

Description: Stage for this ip

Type: `string`

### subscription\_id

Description: The Subscription ID to use

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### schedule

Description: Schedule for the cronjob

Type: `string`

Default: `"0 0 * * *"`

### ttl

Description: Time to live for the backup in form of <x>h<x>m<x>s (example for 14 days: 336h0m0s)

Type: `string`

Default: `"336h0m0s"`

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Development

Use [terraform-docs](https://terraform-docs.io/) to generate the API documentation by running

    terraform fmt .
    terraform-docs .
