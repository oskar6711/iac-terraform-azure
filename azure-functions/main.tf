resource "azurerm_resource_group" "azrm-rg" {
  name     = "azrm-resource-group"
  location = "Poland Central"
}

resource "azurerm_storage_account" "azrm-sa" {
  name                     = "azrmstorageaccount"
  location                 = azurerm_resource_group.azrm-rg.location
  resource_group_name      = azurerm_resource_group.azrm-rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "azrm-asp" {
  name                = "azrm-app-service-plan"
  location            = azurerm_resource_group.azrm-rg.location
  resource_group_name = azurerm_resource_group.azrm-rg.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_linux_function_app" "azrm-lfa" {
  name                       = "azrm-linux-function-app"
  location                   = azurerm_resource_group.azrm-rg.location
  resource_group_name        = azurerm_resource_group.azrm-rg.name
  storage_account_name       = azurerm_storage_account.azrm-sa.name
  storage_account_access_key = azurerm_storage_account.azrm-sa.primary_access_key
  service_plan_id            = azurerm_app_service_plan.azrm-asp.id
  site_config {}
}

resource "azurerm_function_app_function" "azrm-faf" {
  name            = "azrm-function-app-function"
  function_app_id = azurerm_linux_function_app.azrm-lfa.id
  config_json = jsonencode({
    "bindings" = [
      {
        "authLevel" = "function"
        "direction" = "in"
        "methods" = [
          "get",
          "post",
        ]
        "name" = "req"
        "type" = "httpTrigger"
      },
      {
        "direction" = "out"
        "name"      = "$return"
        "type"      = "http"
      },
    ]
  })
}