variable "vnet_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "subnets" {
  type = map(object({
    newbits = number
    netnum  = number
  }))

  default = {
    web = { newbits = 8, netnum = 0 }   # 10.10.0.0/24
    app = { newbits = 8, netnum = 1 }   # 10.10.1.0/24
    gw  = { newbits = 11, netnum = 64 } # 10.10.8.0/27
  }
}

variable "address_space" {
  type        = string
  description = "Adresserommet vnet-et disponerer, som CIDR – for eksempel 10.10.0.0/16"
}