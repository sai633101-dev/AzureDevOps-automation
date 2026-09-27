# Foundation Reference Lookups
variable "rg_name" {
  type        = string
  description = "Resource Group where foundation resources reside"
}

variable "vnet_name" {
  type        = string
  description = "Virtual Network Name"
}

variable "subnet_name" {
  type        = string
  description = "Session Hosts Subnet Name"
}

variable "keyvault_name" {
  type        = string
  description = "Key Vault Name where token is stored"
}

variable "hostpool_name" {
  type        = string
  description = "Target AVD Host Pool Name"
}

# Compute & Scaling Parameters
variable "total_vm_count" {
  type        = number
  description = "Calculated total VM count passed by Pipeline 2"
}

variable "vm_prefix" {
  type        = string
  description = "Naming prefix for session host VMs"
}

variable "vm_size" {
  type        = string
  description = "Azure VM SKU"
}

variable "admin_username" {
  type        = string
  description = "Local admin username for session hosts"
}

variable "admin_password" {
  type        = string
  sensitive   = true
  description = "Local admin password from avd-vm-vars secret"
}
