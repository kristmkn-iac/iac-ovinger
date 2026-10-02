variable "subnet_id" {
  type        = string
  default     = ""
  description = "ID-en til subnet-et VM-ene skal kobles på"
}

variable "vmss_name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

