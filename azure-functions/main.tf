resource "azurerm_resource_group" "af_resource_group" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_storage_account" "af_storage_account" {
  name                     = var.storage_account_name
  location                 = azurerm_resource_group.af_resource_group.location
  resource_group_name      = azurerm_resource_group.af_resource_group.name
  account_tier             = var.tier
  account_replication_type = var.replication_type
}

resource "azurerm_app_service_plan" "af_app_service_plan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.af_resource_group.location
  resource_group_name = azurerm_resource_group.af_resource_group.name
  sku {
    tier = var.tier
    size = var.size
  }
}

resource "azurerm_linux_function_app" "af_linux_function_app" {
  name                       = var.linux_function_app_name
  location                   = azurerm_resource_group.af_resource_group.location
  resource_group_name        = azurerm_resource_group.af_resource_group.name
  storage_account_name       = azurerm_storage_account.af_storage_account.name
  storage_account_access_key = azurerm_storage_account.af_storage_account.primary_access_key
  service_plan_id            = azurerm_app_service_plan.af_app_service_plan.id
  site_config {}
}

resource "azurerm_function_app_function" "af_function_app_function" {
  name            = var.function_app_function_name
  function_app_id = azurerm_linux_function_app.af_linux_function_app.id
  config_json     = jsonencode(var.function_app_function_config)
}