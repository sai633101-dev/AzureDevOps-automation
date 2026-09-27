terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.75.0"
    }
  }

  # Notice the completely separate state file: vms.tfstate
  backend "azurerm" {
    resource_group_name  = "rg-avd"
    storage_account_name = "sttfstateavd7ya84"
    container_name       = "tfstate"
    key                  = "vms.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}
