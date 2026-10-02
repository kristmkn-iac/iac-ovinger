# =============================================================================
#  environments/<miljø>/app/backend.tf
# -----------------------------------------------------------------------------
#  Identisk med nettverks-stackens backend.tf. Det som skiller de to stackene,
#  er `key` – og den står i init-kommandoen, ikke i koden.
#
#    terraform init \
#      -backend-config="../../../shared/backend.hcl" \
#      -backend-config="key=dev/app.tfstate"
#
#  To stack-instanser med samme key er ÉN instans, sett fra Terraform. Det er
#  den dyreste feilen du kan gjøre med en backend-blokk.
# =============================================================================
 
terraform {
  backend "azurerm" {}
}