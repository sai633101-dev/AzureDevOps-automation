locals {
  # If total_vm_count is 3, this creates an array: ["vm-1", "vm-2", "vm-3"]
  vm_names = [for i in range(1, var.total_vm_count + 1) : "${var.vm_prefix}-${i}"]
}

resource "azurerm_network_interface" "nic" {
  for_each            = toset(local.vm_names)
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  for_each              = toset(local.vm_names)
  name                  = each.key
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-11"
    sku       = "win11-25h2-avd"  # Updated to 25H2 as requested
    version   = "latest"
  }
}

# Installs the Entra ID (Azure AD) Login Extension
resource "azurerm_virtual_machine_extension" "aad_join" {
  for_each                   = toset(local.vm_names)
  name                       = "AADLoginForWindows"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm[each.key].id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADLoginForWindows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}

# Installs the AVD Agent and registers the VM to the Host Pool using the Key Vault Token
resource "azurerm_virtual_machine_extension" "avd_register" {
  for_each                   = toset(local.vm_names)
  name                       = "AVD-DSC"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm[each.key].id
  publisher                  = "Microsoft.Powershell"
  type                       = "DSC"
  type_handler_version       = "2.73"
  auto_upgrade_minor_version = true

  settings = <<-SETTINGS
    {
      "modulesUrl": "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_1.0.02714.342.zip",
      "configurationFunction": "Configuration.ps1\\AddSessionHost",
      "properties": {
        "HostPoolName": "${var.hostpool_name}",
        "aadJoin": true
      }
    }
  SETTINGS

  protected_settings = <<-PROTECTED_SETTINGS
    {
      "properties": {
        "registrationInfoToken": "${var.registration_token}"
      }
    }
  PROTECTED_SETTINGS

  depends_on = [azurerm_virtual_machine_extension.aad_join]
}
