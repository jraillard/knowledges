# Getting azurerm client config (tenant, objectid, etc.)
data "azurerm_client_config" "current" {}

# Creating azure resource group
resource "azurerm_resource_group" "dummy_rg" {
  name     = local.rg_group_name
  location = var.project_resources_location
}

# Creation azure storage account
resource "azurerm_storage_account" "dummy_sa" {
  name                     = local.sa_name
  resource_group_name      = azurerm_resource_group.dummy_rg.name
  location                 = azurerm_resource_group.dummy_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

# Creating azure app service plan
resource "azurerm_service_plan" "dummy_service_plan" {
  name                = local.sp_name
  location            = azurerm_resource_group.dummy_rg.location
  resource_group_name = azurerm_resource_group.dummy_rg.name
  os_type             = "Windows"
  sku_name            = "F1"
}

# Creating azure app service running on windows
resource "azurerm_windows_web_app" "dummy_wa" {
  name                = local.wapp_name
  location            = azurerm_resource_group.dummy_rg.location
  resource_group_name = azurerm_resource_group.dummy_rg.name
  service_plan_id     = azurerm_service_plan.dummy_service_plan.id

  /*
   Setting up the managed identity 
   See https://learn.microsoft.com/en-us/azure/app-service/overview-managed-identity?tabs=portal%2Chttp
  */
  identity {
    type = "SystemAssigned"
  }

  # For deeper configs ...
  site_config {
    always_on = false # cannot be true for free app service (is true by default)
  }

  # Setup azure appservice application settings section
  app_settings = {
    # Storage account primary key allowing to create SAS keys
    # ==> Stored in keyvault instead
    SA_PRIMARY_KEY = "@Microsoft.KeyVault(SecretUri=${module.keyvault.sa_pkey_uri})"
  }
}

# Module dedicated to keyvault
module "keyvault" {
  source = "./vault"

  # Module variables
  project_name            = var.project_name
  azurerm_tenant_id       = data.azurerm_client_config.current.tenant_id
  azurerm_object_id       = data.azurerm_client_config.current.object_id
  resource_group_location = azurerm_resource_group.dummy_rg.location
  resource_group_name     = azurerm_resource_group.dummy_rg.name
  sa_primary_key          = azurerm_storage_account.dummy_sa.primary_access_key
  app_service_pid         = azurerm_windows_web_app.dummy_wa.identity[0].principal_id

  # Useless but ...
  depends_on = [
    data.azurerm_client_config.current,
    azurerm_resource_group.dummy_rg,
    azurerm_storage_account.dummy_sa
  ]
}
