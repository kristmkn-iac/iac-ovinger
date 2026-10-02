variable "shortname" {
  type        = string
  description = "Ditt eget kortnavn. Går inn i alle ressursnavn."
}
 
variable "project" {
  type        = string
  description = "Prosjektnavn, del av navnegrunnlaget."
}
 
variable "environment" {
  type        = string
  description = "Miljønavn: dev, test eller prod."
}
 
variable "location" {
  type        = string
  description = "Azure-regionen ressursene opprettes i."
}
 
variable "address_space" {
  type        = string
  description = "Adresserommet dette miljøet disponerer, som CIDR."
}
 
variable "subnets" {
  type        = map(number)
  description = "navn => netnum. Nøkkelen er identiteten, netnum er adressen."
}
 
variable "subscription_id" {
  type        = string
  default     = null
  description = "Settes bare hvis du har flere subscriptions."
}