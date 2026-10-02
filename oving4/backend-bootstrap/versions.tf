terraform {
  required_version = ">= 1.5.0"
 
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

 # K1: HER STÅR DET INGEN backend-BLOKK, OG DET ER MED VILJE.
  #
  # Denne stacken oppretter stedet alle de andre stackene lagrer state. Den
  # kan ikke selv lagre state i en container som ikke finnes ennå – det er
  # hønen og egget. Derfor beholder den local-backenden.
  #
  # Det er akseptabelt nettopp for denne ene stacken, fordi den er så liten:
  # mister du state her, importerer du fire ressurser tilbake med
  # `terraform import` og er ferdig på et kvarter. Mister du state for et
  # miljø, har du mistet oversikten over alt som står der.