output "resource_group_name" {
  description = "Name of the created Azure Resource Group."
  value       = azurerm_resource_group.main.name
}

output "resource_group_location" {
  description = "Azure region of the Resource Group."
  value       = azurerm_resource_group.main.location
}

output "storage_account_name" {
  description = "Name of the created Azure Storage Account."
  value       = azurerm_storage_account.main.name
}

output "storage_account_id" {
  description = "Resource ID of the created Azure Storage Account."
  value       = azurerm_storage_account.main.id
}