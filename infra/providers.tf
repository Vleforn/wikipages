terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "${var.AZURE_BACKEND_RG}"
    storage_account_name = "${var.AZURE_BACKEND_SA}"
    container_name       = "${var.AZURE_BACKEND_CONTAINER}"
    key                  = "${VAR.AZURE_BACKEND_KEY}"
    use_azuread_auth     = true
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}
