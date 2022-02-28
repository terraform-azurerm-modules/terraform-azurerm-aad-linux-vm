output "name" {
  value = azurerm_linux_virtual_machine.vm.name
}

output "id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "private_ip_address" {
  value = azurerm_linux_virtual_machine.vm.private_ip_address
}

output "identity" {
  value = one(azurerm_linux_virtual_machine.vm.identity)
}