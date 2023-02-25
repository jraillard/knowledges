terraform {

  # Providers list needed for the project
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.43.0"
    }
  }

  # Terraform version that is compatible to current project
  required_version = ">= 1.3.7"

  # Support system for tfstate file
  ## Local meaning that it's stored on current folder
  backend "local" {
    path = "states/terraform.tfstate"
  }
}

# Any additionnal features on required providers
# Examples : KeyVault soft delete configuration
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = false
    }
  }
}

