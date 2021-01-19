output "rg_location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.dev_rg.location
}

output "rg_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.dev_rg.name
}

output "rg_virtual_network_name" {
  description = "Name of the virtual network."
  value       = azurerm_virtual_network.dev_network.name
}

output "web_subnet_name" {
  description = "Name of the web subnet"
  value       = azurerm_subnet.web_subnet.name
}