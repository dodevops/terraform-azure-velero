# Terraform management of velero backup on AKS

## Introduction

This module manages velero backup on AKS (Azure Kubernetes Service)

## Usage

Instantiate the module by calling it from Terraform like this:

```hcl
module "azure-velero" {
  source  = "dodevops/velero/azure"
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

- [azurerm_role_assignment.storage-blob-data-contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_storage_account.storaccbackup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) (resource)
- [azurerm_storage_container.storcontbackup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) (resource)
- [helm_release.velero](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) (resource)
- [kubernetes_namespace.velero](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) (resource)

## Required Inputs

The following input variables are required:

### backup\_sp\_id

Description: Service principal ID used for backup

Type: `string`

### backup\_sp\_secret

Description: Secret of the backup service principal

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

### azure\_velero\_plugin\_version

Description: Version of the azure velero plugin to use

Type: `string`

Default: `"v1.3.0"`

### backup\_sp\_objectid

Description: Service principal object ID used for backup. In case an application is used, the service principal object id of the  
app is required as shown in the Enterprise Applications blade."

Type: `string`

Default: `""`

### create\_role\_assignment

Description:     Create a storage-blob-data-contributor role assignment
    (required with this error https://medium.com/datadigest/resolving-an-authorizationpermissionmismatch-from-the-azure-file-copy-task-v4-in-azure-pipelines-654536fe3af5)  
    If a app is used as the backup sp, also provide the app object id.

Type: `bool`

Default: `false`

### exclude\_namespaces

Description: A list of namespaces to exclude from velero backup

Type: `list(string)`

Default:

```json
[
  "velero",
  "kube-system",
  "kube-public",
  "kube-node-lease"
]
```

### include\_namespaces

Description: A list of namespaces to include in velero backup

Type: `list(string)`

Default:

```json
[
  "*"
]
```

### schedule

Description: Schedule for the cronjob

Type: `string`

Default: `"0 0 * * *"`

### snapshots\_enabled

Description: Enable Velero snapshots

Type: `bool`

Default: `true`

### ttl

Description: Time to live for the backup in form of <x>h<x>m<x>s (example for 14 days: 336h0m0s)

Type: `string`

Default: `"336h0m0s"`

### velero\_version

Description: Velero Helm Chart version to use

Type: `string`

Default: `"2.26.3"`

## Outputs

The following outputs are exported:

### storage\_account\_name

Description: The name of the created backup storage account

### storage\_container\_name

Description: The name of the created backup storage container
<!-- END_TF_DOCS -->

## Development

Use [terraform-docs](https://terraform-docs.io/) to generate the API documentation by running

    terraform fmt .
    terraform-docs .
