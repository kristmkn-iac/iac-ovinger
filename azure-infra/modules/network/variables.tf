variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type    = string
  default = "vnet-tf-demo-01"
}

variable "nsg_name" {
  type    = string
  default = "nsg-tf-demo"
}

variable "subnet_name" {
  type    = string
  default = "snet-tf-demo-001"
}

