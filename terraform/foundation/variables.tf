variable "location" {
  type        = string
  description = "Target Azure Region"
}

variable "rg_name" {
  type        = string
  description = "Foundation Resource Group Name"
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
  description = "Key Vault Name for AVD Secrets"
}

variable "workspace_name" {
  type        = string
  description = "Log Analytics Workspace Name"
}

variable "hostpool_name" {
  type        = string
  description = "AVD Host Pool Name"
}

variable "workspace_name_avd" {
  type        = string
  description = "AVD Workspace Name"
}

variable "appgroup_name" {
  type        = string
  description = "AVD Application Group Name"
}
