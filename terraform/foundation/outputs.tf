# These outputs are just for terminal visibility during Pipeline 1.
# Phase 2 will use 'data' blocks to look these up dynamically.
output "resource_group_name" {
  value = module.resource_group.name
}

output "subnet_id" {
  value = module.network.subnet_id
}

output "hostpool_name" {
  value = module.hostpool.name
}

output "keyvault_name" {
  value = module.keyvault.name
}
