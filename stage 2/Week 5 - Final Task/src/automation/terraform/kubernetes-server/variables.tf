variable "resource_group_name" {
  default = "rg-kubernetes"
}

variable "location" {
  default = "Australia East"
}

variable "vnet_name" {
  default = "vnet-terraform"
}

variable "vnet_address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet_name" {
  default = "subnet-terraform"
}

variable "subnet_address_prefixes" {
  default = ["10.0.1.0/24"]
}

variable "nsg_name" {
  default = "nsg-terraform"
}

variable "username" {
  default = "azureuser"
}

variable "vm_size" {
  default = "Standard_B2als_v2"
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