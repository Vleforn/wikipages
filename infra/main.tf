# Azure resources
resource "azurerm_resource_group" "wikipages" {
  name     = "rg-wikipages-dev-weu-001"
  location = "westeurope"
}

resource "azurerm_storage_account" "wikipages" {
  name                     = "stwpweu${local.name_suffix}"
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

resource "azurerm_databricks_access_connector" "wikipages" {
  name                = "dac-wikipages-dev-weu-001"
  resource_group_name = azurerm_resource_group.wikipages.name
  location            = azurerm_resource_group.wikipages.location

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "dac-storage" {
  scope                = azurerm_storage_account.wikipages.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.wikipages.identity[0].principal_id
  depends_on           = [azurerm_databricks_access_connector.wikipages, azurerm_storage_account.wikipages]
}
