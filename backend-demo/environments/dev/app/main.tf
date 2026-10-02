data "terraform_remote_state" "nettverk" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-tfstate-kristmkn"
    storage_account_name = "sttfstatekristmkn01"
    container_name       = "tfstate"
    key                  = "dev/nettverk.tfstate"
    use_azuread_auth     = true
  }
}

module "compute" {
  source = "../../../modules/compute"

  rg_name        = var.rg_name
  location       = var.location
  base_name      = var.base_name
  vm_size        = var.vm_size
  admin_username = var.admin_username
  admin_password = var.admin_password
  tags           = var.tags

  subnet_id = data.terraform_remote_state.nettverk.outputs.subnet_ids[var.vm_subnet_key]
}