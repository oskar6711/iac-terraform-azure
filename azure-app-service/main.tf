resource "azurerm_resource_group" "as_resource_group" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_app_service_plan" "as_app_service_plan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.as_resource_group.location
  resource_group_name = azurerm_resource_group.as_resource_group.name

  sku {
    tier = var.tier
    size = var.size
  }
}

resource "azurerm_app_service" "as_app_service" {
  name                = var.app_service_name
  location            = azurerm_resource_group.as_resource_group.location
  resource_group_name = azurerm_resource_group.as_resource_group.name
  app_service_plan_id = azurerm_app_service_plan.as_app_service_plan.id
}
