resource "azurerm_resource_group" "smoketest" {
  name     = "rg-smoketest-dev-weu-001"
  location = "westeurope"

  tags = {
    purpose = "terraform-smoketest"
    managed = "terraform"
  }
}

resource "azurerm_resource_group" "dysonschwinger" {
  name     = "rg-dysonschwinger-dev-weu-001"
  location = "westeurope"

  tags = {
    purpose = "terraform-dysonschwinger"
    managed = "terraform"
  }
}

output "resource_group_id" {
  value = azurerm_resource_group.smoketest.id
}

output "resource_group_dysonschwinger_id" {
  value = azurerm_resource_group.smoketest.id
}
