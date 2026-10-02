terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = lower(format("%s-%s", var.vnet_name, var.environment))
  address_space       = [var.address_space]
  location            = var.location
  resource_group_name = var.rg_name

  tags = var.common_tags
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                 = format("snet-%s", each.key)
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = [cidrsubnet(var.address_space, each.value.newbits, each.value.netnum)]
}


resource "azurerm_subnet_network_security_group_association" "snet_nsg" {
  for_each = azurerm_subnet.subnet

  subnet_id                 = each.value.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.environment}"
  location            = var.location
  resource_group_name = var.rg_name

  tags = var.common_tags
}

