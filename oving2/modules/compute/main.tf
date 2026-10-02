terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

resource "azurerm_network_interface" "nic" {
  name                = lower(format("%s-%s", var.nic_name, var.environment))
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.common_tags
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = lower(format("%s-%s", var.vm_name, var.environment))
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.vm_size

  admin_username = "adminuser"
  admin_password = "Bytt-meg-1234!"

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  tags = var.common_tags
}

