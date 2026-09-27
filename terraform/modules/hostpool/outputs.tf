output "id" { value = azurerm_virtual_desktop_host_pool.hp.id }
output "name" { value = azurerm_virtual_desktop_host_pool.hp.name }
output "registration_token" { 
  value     = azurerm_virtual_desktop_host_pool_registration_info.hp_token.token 
  sensitive = true
}
