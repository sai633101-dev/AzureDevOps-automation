module "resource_group" {
  source   = "../modules/resource_group"
  name     = var.rg_name
  location = var.location
}

module "network" {
  source              = "../modules/network"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  vnet_name           = var.vnet_name
  subnet_name         = var.subnet_name
}

module "keyvault" {
  source              = "../modules/keyvault"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  keyvault_name       = var.keyvault_name
}

module "loganalytics" {
  source              = "../modules/loganalytics"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  workspace_name      = var.workspace_name
}

module "hostpool" {
  source              = "../modules/hostpool"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  hostpool_name       = var.hostpool_name
}

module "workspace" {
  source              = "../modules/workspace"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  workspace_name      = var.workspace_name_avd
}

module "application_group" {
  source              = "../modules/application_group"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  appgroup_name       = var.appgroup_name
  hostpool_id         = module.hostpool.id
  workspace_id        = module.workspace.id
}

# -------------------------------------------------------------------------
# SECURE HANDOFF: Save the Registration Token to Key Vault for Pipeline 2
# -------------------------------------------------------------------------
resource "azurerm_key_vault_secret" "avd_token" {
  name         = "HostPoolRegistrationToken"
  value        = module.hostpool.registration_token
  key_vault_id = module.keyvault.id

  # Ensure the Key Vault is fully provisioned before trying to add a secret
  depends_on   = [module.keyvault]
}
