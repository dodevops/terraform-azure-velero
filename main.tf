resource "azurerm_storage_account" "storaccbackup" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = var.location
  name                     = "${lower(var.project)}${lower(var.stage)}storaccbackup"
  resource_group_name      = var.resource_group
}

resource "azurerm_storage_container" "storcontbackup" {
  name                 = "${lower(var.project)}${lower(var.stage)}storcontbackup"
  storage_account_name = azurerm_storage_account.storaccbackup.name
}

resource "kubernetes_namespace" "velero" {
  metadata {
    name = "velero"
  }
}

resource "helm_release" "velero" {
  name       = "velero"
  repository = "https://vmware-tanzu.github.io/helm-charts"
  chart      = "velero"
  version    = "2.23.12"
  namespace  = kubernetes_namespace.velero.metadata[0].name

  set {
    name  = "configuration.provider"
    value = "azure"
  }
  set {
    name  = "configuration.backupStorageLocation.name"
    value = "default"
  }
  set {
    name  = "configuration.backupStorageLocation.bucket"
    value = azurerm_storage_container.storcontbackup.name
  }
  set {
    name  = "configuration.backupStorageLocation.prefix"
    value = "kubernetes"
  }
  set {
    name  = "configuration.backupStorageLocation.config.resourceGroup"
    value = var.resource_group
  }
  set {
    name  = "configuration.backupStorageLocation.config.storageAccount"
    value = azurerm_storage_account.storaccbackup.name
  }
  set {
    name  = "configuration.backupStorageLocation.config.subscriptionId"
    value = var.subscription_id
  }
  # TODO: Why?
  #  set {
  #    name  = "snapshotsEnabled"
  #    value = "false"
  #  }
  set {
    name  = "credentials.secretContents.cloud"
    value = <<EOF
AZURE_SUBSCRIPTION_ID=${var.subscription_id}
AZURE_TENANT_ID=${var.backup_tenant_id}
AZURE_CLIENT_ID=${var.backup_application_id}
AZURE_CLIENT_SECRET=${var.backup_application_secret}
AZURE_RESOURCE_GROUP=${var.resource_group}
AZURE_CLOUD_NAME="AzurePublicCloud"
EOF
  }
  set {
    name  = "initContainers[0].name"
    value = "velero-plugin-for-azure"
  }
  # 1.3.0 is released, but not compatible with the helm chart, which installs velero 1.6 only,
  # see https://github.com/vmware-tanzu/velero-plugin-for-microsoft-azure#compatibility
  set {
    name  = "initContainers[0].image"
    value = "velero/velero-plugin-for-microsoft-azure:v1.2.1"
  }
  set {
    name  = "initContainers[0].volumeMounts[0].mountPath"
    value = "/target"
  }
  set {
    name  = "initContainers[0].volumeMounts[0].name"
    value = "plugins"
  }
  set {
    name  = "schedules.backup.schedule"
    value = var.schedule
  }
  set {
    name  = "schedules.backup.template.excludedNamespaces[0]"
    value = "kube-node-lease"
  }
  set {
    name  = "schedules.backup.template.excludedNamespaces[1]"
    value = "kube-public"
  }
  set {
    name  = "schedules.backup.template.excludedNamespaces[2]"
    value = "kube-system"
  }
  set {
    name  = "schedules.backup.template.excludedNamespaces[3]"
    value = "velero"
  }
  set {
    name  = "schedules.backup.template.includedNamespaces[0]"
    value = "*"
  }
  set {
    name  = "schedules.backup.template.ttl"
    value = var.ttl
  }
}
