# =============================================================================
#  environments/<miljø>/nettverk/backend.tf
# -----------------------------------------------------------------------------
#  K6: blokka er TOM, og det er hele poenget.
#
#  Den må stå der – det er den som velger backend-TYPEN. Sletter du den, faller
#  Terraform tilbake til local-backenden og state havner i mappa igjen, uten at
#  noe feiler.
#
#  Verdiene kommer utenfra ved init, fordi backend-blokka ikke godtar
#  variabler: Terraform må vite hvor state ligger FØR den kan lese variabler.
# =============================================================================
 
terraform {
  backend "azurerm" {}
}