terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-wikipages-dev-weu-001"
    storage_account_name = "stterraformwikipagesdevweu001"
    container_name       = "tfstate"
    key                  = "wikipages.tfstate"
    use_azuread_auth     = true
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}
