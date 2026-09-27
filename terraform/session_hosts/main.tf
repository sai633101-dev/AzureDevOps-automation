module "session_hosts" {
  source              = "../modules/session_host_vms"
  
  # Network and Location passed from data lookups
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  subnet_id           = data.azurerm_subnet.subnet.id
  
  # AVD Join info passed from variables and Key Vault
  hostpool_name       = var.hostpool_name
  registration_token  = data.azurerm_key_vault_secret.avd_token.value
  
  # Compute specifications (Passed dynamically from the Azure DevOps Pipeline)
  total_vm_count      = var.total_vm_count
  vm_prefix           = var.vm_prefix
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}
