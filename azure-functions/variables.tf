variable "resource_group_name" {
  type    = string
  default = "af-resource-group"
}

variable "resource_group_location" {
  type    = string
  default = "Poland Central"
}

variable "storage_account_name" {
  type    = string
  default = "afstorageaccount"
}

variable "tier" {
  type    = string
  default = "Standard"
}

variable "replication_type" {
  type    = string
  default = "LRS"
}

variable "app_service_plan_name" {
  type    = string
  default = "af-app-service-plan"
}

variable "size" {
  type    = string
  default = "S1"
}

variable "linux_function_app_name" {
  type    = string
  default = "af-linux-function-app"
}

variable "function_app_function_name" {
  type    = string
  default = "af-function-app-function"
}

variable "function_app_function_config" {
  default = {
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
  }
}