terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = lower(format("%s-%s", var.rg_name, var.environment))
  location = var.location

  tags = local.common_tags
}

module "network" {
  source = "../../modules/network"
  address_space = var.address_space[0]
  rg_name       = azurerm_resource_group.rg.name
  location      = var.location
  environment   = var.environment
  vnet_name     = var.vnet_name
  common_tags   = local.common_tags
}

module "compute" {
  source = "../../modules/compute"

  rg_name     = azurerm_resource_group.rg.name
  location    = var.location
  environment = var.environment
  nic_name    = var.nic_name
  vm_name     = var.vm_name
  vm_size     = var.vm_size
  subnet_id   = module.network.subnet_ids["web"]
  common_tags = local.common_tags
}

locals {
  common_tags = {
    environment = var.environment
    owner       = "kristine"
    managedby   = "terraform"
  }
}

