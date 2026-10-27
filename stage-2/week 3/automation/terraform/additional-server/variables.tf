variable "resource_group_name" {
  default = "rg-additional-server"
}

variable "location" {
  default = "Japan East"
}

variable "vnet_name" {
  default = "vnet-additional-server"
}

variable "vnet_address_space" {
  default = ["10.1.0.0/16"]
}

variable "subnet_name" {
  default = "subnet-additional-server"
}

variable "subnet_address_prefixes" {
  default = ["10.1.1.0/24"]
}

variable "nsg_name" {
  default = "nsg-additional-server"
}

variable "username" {
  default = "azureuser"
}

variable "vm_size" {
  default = "Standard_B2ats_v2"
}

variable "ssh_public_key_path" {
  default = "~/.ssh/id_ed25519.pub"
}

variable "storage_account_type" {
  default = "Standard_LRS"
}

variable "data_disk_size_gb" {
  default = 10
}

variable "data_disk_caching" {
  default = "ReadWrite"
}
