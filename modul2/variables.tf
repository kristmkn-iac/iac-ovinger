variable "location" {
  description = "Deployment location for the resources"
  type        = string
  default     = "West Europe"
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-demo-kristmkn"
}

variable "sa_name" {
  description = "Name of the storage account. Must be globally unique."
  type        = string
}

variable "company" {
  type        = string
  description = "Company name"
}

variable "project" {
  type        = string
  description = "Project name"
}

variable "billing_code" {
  type        = string
  description = "Billing code - identifies which department is charged"
}


variable "owner" {
  type        = string
  description = "Owner of the resources"
  default     = "kristmkn"
}

variable "prefix" {
  type        = number
  description = "Prefix for resources"
  default     = 161000
}