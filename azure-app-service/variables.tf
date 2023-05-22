variable "resource_group_name" {
  type    = string
  default = "as-resource-group"
}

variable "resource_group_location" {
  type    = string
  default = "Poland Central"
}

variable "app_service_plan_name" {
  type    = string
  default = "as-app-service-plan"
}

variable "tier" {
  type    = string
  default = "Standard"
}

variable "size" {
  type    = string
  default = "S1"
}

variable "app_service_name" {
  type    = string
  default = "oszymczyk-app-service"
}