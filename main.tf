terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.97.0"
    }
  }
}

locals {}

resource "azurerm_network_interface" "vm" {
  name                = "${var.name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  computer_name                   = var.name
  admin_username                  = var.admin_username
  disable_password_authentication = true
  size                            = var.size

  network_interface_ids = [azurerm_network_interface.vm.id]

  // source_image_reference {
  //   publisher = "Canonical"
  //   offer     = "UbuntuServer"
  //   sku       = "18.04-LTS"
  //   version   = "latest"
  // }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    name                 = "${var.name}-os"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  custom_data = base64encode(coalesce(var.cloud_init,file("${path.module}/cloud_init.yaml")))

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.admin_ssh_public_key_file)
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_virtual_machine_extension" "AADSSHLoginForLinux" {
  name                       = "AADSSHLoginForLinux"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm.id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADSSHLoginForLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}
