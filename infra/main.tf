resource "azurerm_resource_group" "smoketest" {
  name     = "rg-smoketest-dev-weu-001"
  location = "westeurope"

  tags = {
    purpose = "terraform-smoketest"
    managed = "terraform"
  }
}

output "resource_group_id" {
  value = azurerm_resource_group.smoketest.id
}
