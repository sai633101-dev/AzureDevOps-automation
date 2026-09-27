variable "location" { 
  type    = string 
  default = "eastus" 
}
variable "rg_name" { 
  type    = string 
  default = "rg-avd-mtech-prod" 
}
variable "vnet_name" { 
  type    = string 
  default = "vnet-avd-prod" 
}
variable "subnet_name" { 
  type    = string 
  default = "snet-avd-sessionhosts" 
}
variable "keyvault_name" { 
  type    = string 
  default = "kv-avd-mtech-2026" # Key vault names must be globally unique
}
variable "workspace_name" { 
  type    = string 
  default = "law-avd-mtech" 
}
variable "hostpool_name" { 
  type    = string 
  default = "hp-avd-mtech-01" 
}
variable "workspace_name_avd" { 
  type    = string 
  default = "ws-avd-mtech-01" 
}
variable "appgroup_name" { 
  type    = string 
  default = "ag-avd-mtech-01" 
}
