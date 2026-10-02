variable "shortname" {
  type        = string
  description = "kristmkn" 
}
 
variable "location" {
  type        = string
  default     = "norwayeast"
  description = "Azure-regionen backend-en opprettes i."
}
 
variable "subscription_id" {
  type        = string
  default     = null
  description = <<-TEKST
    Settes bare hvis du har flere subscriptions. Står den som null, brukes
    ARM_SUBSCRIPTION_ID eller den aktive subscriptionen fra `az account show`.
  TEKST
}
 