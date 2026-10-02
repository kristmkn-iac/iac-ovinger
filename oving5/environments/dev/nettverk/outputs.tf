# =============================================================================
#  environments/<miljø>/nettverk/outputs.tf  –  GRENSESNITTET UT
# -----------------------------------------------------------------------------
#  K8: dette er ikke lenger noe som skrives i terminalen. Det er et API.
#
#  App-stacken leser disse verdiene med terraform_remote_state. Å fjerne eller
#  døpe om en av dem er en breaking change – og du merker det ikke selv, det er
#  app-stackens plan som feiler.
#
#  VIKTIG: bare outputs på ROOT-NIVÅ er synlige utenfra. En output inne i
#  modules/network/ er IKKE lesbar for en annen stack, uansett hvor riktig den
#  ser ut. Den må eksporteres videre herfra. Kjør `terraform output` – det som
#  står der, er nøyaktig det app-stacken kan lese.
# =============================================================================
 
output "subnet_ids" {
  value       = module.network.subnet_ids
  description = "Subnet-ID per subnettnavn. LESES AV APP-STACKEN – ikke fjern."
}
 
output "vnet_name" {
  value       = module.network.vnet_name
  description = "Navnet på det virtuelle nettverket."
}
 
output "subnet_prefixes" {
  value       = module.network.subnet_prefixes
  description = "Utregnet adresseprefiks per subnett. Til feilsøking."
}