# Resource for creating an azure KeyVault
resource "azurerm_key_vault" "dummy-kv" {
  name                        = local.kv_name
  location                    = var.resource_group_location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.azurerm_tenant_id
  soft_delete_retention_days  = 7
  enabled_for_disk_encryption = true
  purge_protection_enabled    = false

  sku_name = "standard"
}

# Resources for adding acces policies to key vault
# Azure account Policy (object_id)
resource "azurerm_key_vault_access_policy" "keyvault_aza_policy" {
  key_vault_id = azurerm_key_vault.dummy-kv.id
  tenant_id    = var.azurerm_tenant_id
  object_id    = var.azurerm_object_id

  # Basic permission for key (don't use it)
  key_permissions = [
    "Get",
  ]
  # More permissions for key (in order to edit through tf applies)
  secret_permissions = [
    "Get", "Set", "Delete"
  ]
  # Basic permission for key (don't use it)
  storage_permissions = [
    "Get",
  ]
}
# AppService policy
resource "azurerm_key_vault_access_policy" "keyvault_appservice_policy" {
  key_vault_id = azurerm_key_vault.dummy-kv.id
  tenant_id    = var.azurerm_tenant_id
  object_id    = var.app_service_pid

  secret_permissions = [
    "Get"
  ]
}

# Resource for adding secrets on key vault
resource "azurerm_key_vault_secret" "dummy-kv-secret" {
  name         = local.kv_secret_name
  value        = var.sa_primary_key
  key_vault_id = azurerm_key_vault.dummy-kv.id
}
