# Azure resources
resource "azurerm_resource_group" "wikipages" {
  name     = "rg-wikipages-dev-weu-001"
  location = "westeurope"
}

resource "azurerm_storage_account" "wikipages" {
  name                     = "stwpvleforndevweu001"
  location                 = azurerm_resource_group.wikipages.location
  resource_group_name      = azurerm_resource_group.wikipages.name
  account_replication_type = "LRS"
  account_tier             = "Standard"
  is_hns_enabled           = true
}

# TODO: Connect containers to databricks as external locations
resource "azurerm_storage_container" "inbox" {
  name               = "inbox"
  storage_account_id = azurerm_storage_account.wikipages.id
}

resource "azurerm_storage_container" "bronze" {
  name               = "bronze"
  storage_account_id = azurerm_storage_account.wikipages.id
}

resource "azurerm_storage_container" "silver" {
  name               = "silver"
  storage_account_id = azurerm_storage_account.wikipages.id
}

resource "azurerm_storage_container" "gold" {
  name               = "gold"
  storage_account_id = azurerm_storage_account.wikipages.id
}

resource "azurerm_databricks_workspace" "wikipages" {
  name                = "adb-wikipages-dev-weu-001"
  location            = azurerm_resource_group.wikipages.location
  resource_group_name = azurerm_resource_group.wikipages.name
  sku                 = "premium"
}

# # TODO: keyvault configuration
# resource "azurerm_key_vault" "wikipages" {
#   name = "kv-wikipages-dev-weu-001"
#   location = azurerm_resource_group.wikipages.location
#   resource_group_name = azurerm_resource_group.wikipages.name
#   tenant_id = "???"
#   sku_name = "???"
# }


# Databricks resources

# TODO: Unity Catalog???

# output "resource_group_id" {
#   value = azurerm_resource_group.smoketest.id
# }

# output "resource_group_dysonschwinger_id" {
#   value = azurerm_resource_group.smoketest.id
# }
