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

  access_policy {
    tenant_id = var.azurerm_tenant_id
    object_id = var.azurerm_object_id

    # You must give permission in order to manage azure key vault secrets, keys and storage configuration 
    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get", "Set", "Delete"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

# Resource for adding secrets on key vault
resource "azurerm_key_vault_secret" "dummy-kv-secret" {
  name         = local.kv_secret_name
  value        = var.sa_primary_key
  key_vault_id = azurerm_key_vault.dummy-kv.id
}
