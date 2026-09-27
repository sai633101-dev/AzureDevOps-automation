resource "azurerm_virtual_desktop_workspace" "ws" {
  name                = var.workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
}
