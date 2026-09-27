terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.75.0"
    }
  }

  # This state file will be completely isolated from the VM compute state
  backend "azurerm" {
    resource_group_name  = "rg-avd"
    storage_account_name = "sttfstateavd7ya84"
    container_name       = "tfstate"
    key                  = "foundation.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
  use_oidc                   = true
  skip_provider_registration = true
}
