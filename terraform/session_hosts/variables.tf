# Lookup References (Must match the Foundation defaults)
variable "rg_name" { type = string, default = "rg-avd-mtech-prod" }
variable "vnet_name" { type = string, default = "vnet-avd-prod" }
variable "subnet_name" { type = string, default = "snet-avd-sessionhosts" }
variable "keyvault_name" { type = string, default = "kv-avd-mtech-2026" }
variable "hostpool_name" { type = string, default = "hp-avd-mtech-01" }

# Scale & Compute Parameters (Pipeline 2 will inject total_vm_count and admin_password dynamically)
variable "total_vm_count" { 
  type        = number 
  description = "The absolute number of VMs to maintain, calculated by the pipeline."
}
variable "vm_prefix" { 
  type    = string 
  default = "avd-sh" 
}
variable "vm_size" { 
  type    = string 
  default = "Standard_B2s" # Cost-effective for Azure Free Tier
}
variable "admin_username" { 
  type    = string 
  default = "avdadmin" 
}
variable "admin_password" { 
  type      = string 
  sensitive = true 
}
