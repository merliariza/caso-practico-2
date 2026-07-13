# Public IP address used by Ansible to connect to the virtual machine
output "vm_public_ip" {
  description = "Public IP address of the virtual machine"
  value       = azurerm_public_ip.main.ip_address
}

# Username used for SSH connections to the virtual machine
output "vm_admin_username" {
  description = "Administrator username of the virtual machine"
  value       = azurerm_linux_virtual_machine.vm.admin_username
}

# Login server of the Azure Container Registry
output "acr_login_server" {
  description = "Login server of the Azure Container Registry"
  value       = azurerm_container_registry.main.login_server
}

# Name of the Azure Container Registry
output "acr_name" {
  description = "Name of the Azure Container Registry"
  value       = azurerm_container_registry.main.name
}
