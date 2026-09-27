# 1. Look up the existing Resource Group
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

# 2. Look up the existing Subnet for the NICs
data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

# 3. Look up the existing Key Vault created in Phase 1
data "azurerm_key_vault" "kv" {
  name                = var.keyvault_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

# 4. Securely extract the Host Pool Registration Token from the Key Vault
data "azurerm_key_vault_secret" "avd_token" {
  name         = "HostPoolRegistrationToken"
  key_vault_id = data.azurerm_key_vault.kv.id
}
