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

module "rg_kristmkn" {
  source    = "./resource-group"
  base_name = "TFDemo"
  location  = "Norway East"
}

module "st_kristmkn" {
  source    = "./storage-account"
  base_name = "TFDemo"
  rg_name   = module.rg_kristmkn.rg_name
  location  = "Norway East"
}
