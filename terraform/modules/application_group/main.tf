resource "azurerm_virtual_desktop_application_group" "ag" {
  name                = var.appgroup_name
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = "Desktop"
  host_pool_id        = var.hostpool_id
}

# Automatically links the App Group to the AVD Workspace
resource "azurerm_virtual_desktop_workspace_application_group_association" "ws_ag_assoc" {
  workspace_id         = var.workspace_id
  application_group_id = azurerm_virtual_desktop_application_group.ag.id
}
