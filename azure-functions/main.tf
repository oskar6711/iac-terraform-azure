resource "azurerm_resource_group" "azrm-rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_storage_account" "azrm-sa" {
  name                     = var.storage_account_name
  location                 = azurerm_resource_group.azrm-rg.location
  resource_group_name      = azurerm_resource_group.azrm-rg.name
  account_tier             = var.tier
  account_replication_type = var.replication_type
}

resource "azurerm_app_service_plan" "azrm-asp" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.azrm-rg.location
  resource_group_name = azurerm_resource_group.azrm-rg.name
  sku {
    tier = var.tier
    size = var.size
  }
}

resource "azurerm_linux_function_app" "azrm-lfa" {
  name                       = var.linux_function_app_name
  location                   = azurerm_resource_group.azrm-rg.location
  resource_group_name        = azurerm_resource_group.azrm-rg.name
  storage_account_name       = azurerm_storage_account.azrm-sa.name
  storage_account_access_key = azurerm_storage_account.azrm-sa.primary_access_key
  service_plan_id            = azurerm_app_service_plan.azrm-asp.id
  site_config {}
}

resource "azurerm_function_app_function" "azrm-faf" {
  name            = var.function_app_function_name
  function_app_id = azurerm_linux_function_app.azrm-lfa.id
  config_json     = jsonencode(var.function_app_function_config)
}