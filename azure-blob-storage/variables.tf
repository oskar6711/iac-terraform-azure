variable "resource_group_name" {
  type    = string
  default = "bs-resource-group"
}

variable "resource_group_location" {
  type    = string
  default = "Poland Central"
}

variable "storage_account_name" {
  type    = string
  default = "bsstoragewsb"
}

variable "tier" {
  type    = string
  default = "Standard"
}

variable "replication_type" {
  type    = string
  default = "LRS"
}

variable "storage_container_name" {
  type    = string
  default = "bs-storage-container"
}

variable "access_type" {
  type    = string
  default = "private"
}

variable "storage_blob_name" {
  type    = string
  default = "bs-storage-blob"
}

variable "type" {
  type    = string
  default = "Block"
}

variable "size" {
  type    = number
  default = 512
}