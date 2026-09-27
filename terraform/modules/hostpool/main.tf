resource "azurerm_virtual_desktop_host_pool" "hp" {
  name                = var.hostpool_name
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = "Pooled"
  load_balancer_type  = "BreadthFirst"
}

# Generates the secure registration token required for VMs to join
resource "azurerm_virtual_desktop_host_pool_registration_info" "hp_token" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.hp.id
  expiration_date = timeadd(timestamp(), "48h") # Generates a 48-hour valid token

  # Prevents Terraform from regenerating the token on every run unless it expires
  lifecycle {
    ignore_changes = [expiration_date]
  }
}
