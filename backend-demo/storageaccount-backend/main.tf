terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }
}

provider "azurerm" {
  features {}
  use_cli = true
  storage_use_azuread = true

  # Fra og med azurerm 5.0 registreres ingen resource providers automatisk
  resource_providers_to_register = ["Microsoft.Storage"]
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-tfstate-kristmkn"
  location = "westeurope"
}

resource "azurerm_storage_account" "sa" {
  name                     = "sttfstatekristmkn01" # må være globalt unikt
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  shared_access_key_enabled       = false
    default_to_oauth_authentication = true
    allow_nested_items_to_be_public = false
    min_tls_version                 = "TLS1_2"

  blob_properties {
  versioning_enabled = true

  delete_retention_policy {
    days = 7
  }

  container_delete_retention_policy {
    days = 7
  }
}

lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_container" "sc" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"
}

# Hent innlogget bruker fra Entra ID
data "azurerm_client_config" "current" {}

# Tilgang slik at innlogget bruker kan liste innholdet i containeren
resource "azurerm_role_assignment" "blob_reader" {
  scope                = azurerm_storage_account.sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id

  # Sørg for at SA og container er ferdig opprettet før RBAC forsøkes
  depends_on = [
    azurerm_storage_account.sa,
    azurerm_storage_container.sc
  ]
}

