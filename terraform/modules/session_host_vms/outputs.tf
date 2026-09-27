output "vm_ids" {
  value = [for vm in azurerm_windows_virtual_machine.vm : vm.id]
}
