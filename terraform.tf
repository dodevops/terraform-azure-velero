terraform {
  required_version = ">=1.3.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.81.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">=2.4.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.8.0"
    }
  }
}