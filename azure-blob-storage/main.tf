resource "azurerm_resource_group" "bs_resource_group" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_storage_account" "bs_storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.bs_resource_group.name
  location                 = azurerm_resource_group.bs_resource_group.location
  account_tier             = var.tier
  account_replication_type = var.replication_type
}

resource "azurerm_storage_container" "bs_storage_container" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.bs_storage_account.name
  container_access_type = var.access_type
}

resource "azurerm_storage_blob" "bs_storage_blob" {
  name                   = var.storage_blob_name
  storage_account_name   = azurerm_storage_account.bs_storage_account.name
  storage_container_name = azurerm_storage_container.bs_storage_container.name
  type                   = var.type
  size                   = var.size
}