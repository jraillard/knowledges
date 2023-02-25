variable "project_name" {
  description = "Project name"
  type        = string
  default     = "dummy-jra"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "resource_group_location" {
  description = "Resource group location"
  type        = string
  default     = "westeurope"
}

variable "azurerm_tenant_id" {
  description = "Azure tenant id"
  type        = string
}

variable "azurerm_object_id" {
  description = "Azure object id"
  type        = string
}

variable "sa_primary_key" {
  description = "Storage account primary key"
  type        = string
  sensitive   = true # as it is a secret, it mustn't be shown through logs / outputs !
}

variable "app_service_pid" {
  description = "App service principal id"
  type        = string
}
