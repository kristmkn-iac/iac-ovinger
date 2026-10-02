# =============================================================================
#  environments/<miljø>/nettverk/main.tf  –  PROVIDER STACK
# -----------------------------------------------------------------------------
#  «Provider» i kapittel 9s betydning: stacken som LEVERER en verdi andre
#  trenger. Ikke å forveksle med provider "azurerm" – plugin-en som snakker
#  med Azure.
#
#  Denne fila er IDENTISK i dev og prod. Alt som skiller dem ligger i
#  terraform.tfvars.
# =============================================================================
 
terraform {
  required_version = ">= 1.5.0"
 
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }
}
 
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
 
locals {
  base_name = lower(format("%s-%s-%s", var.project, var.environment, var.shortname))
 
  tags = {
    environment = var.environment
    owner       = var.shortname
    project     = var.project
    stack       = "nettverk"
    managedby   = "terraform"
  }
}
 
resource "azurerm_resource_group" "rg" {
  name     = format("rg-nett-%s", local.base_name)
  location = var.location
  tags     = local.tags
}
 
# Modulen er UENDRET fra Oppgave 3. Det er bare hvem som kaller den som er nytt:
# før lå dette i stacks/, sammen med compute. Nå er nettverket sin egen stack
# med sin egen state og sin egen utrulling.
module "network" {
  source = "../../../modules/network"
 
  rg_name       = azurerm_resource_group.rg.name
  location      = var.location
  base_name     = local.base_name
  address_space = var.address_space
  subnets       = var.subnets
  tags          = local.tags
}