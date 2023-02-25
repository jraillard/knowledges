
output "sa_pkey_uri" {
  description = "Storage account primary key uri on keyvault"
  sensitive   = true
  value       = azurerm_key_vault_secret.dummy-kv-secret.versionless_id
}
