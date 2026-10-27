# REGIONS


variable "regions" {
  default = {
    west_us_2 = {
      location                  = "West US 2"
      resource_group_name       = "rg-west-us-2"
      vnet_name                 = "vnet-west-us-2"
      vnet_address_space        = "10.0.0.0/16"
      subnet_name               = "subnet-west-us-2"
      subnet_address_prefix     = "10.0.1.0/24"
      nsg_name                  = "nsg-west-us-2"
    }

    east_asia = {
      location                  = "East Asia"
      resource_group_name       = "rg-east-asia"
      vnet_name                 = "vnet-east-asia"
      vnet_address_space        = "10.1.0.0/16"
      subnet_name               = "subnet-east-asia"
      subnet_address_prefix     = "10.1.1.0/24"
      nsg_name                  = "nsg-east-asia"
    }

    korea_central = {
      location                  = "Korea Central"
      resource_group_name       = "rg-korea-central"
      vnet_name                 = "vnet-korea-central"
      vnet_address_space        = "10.2.0.0/16"
      subnet_name               = "subnet-korea-central"
      subnet_address_prefix     = "10.2.1.0/24"
      nsg_name                  = "nsg-korea-central"
    }
  }
}



# SERVERS


variable "servers" {
  default = {
    appserver = {
      region = "west_us_2"
    }

    gateway = {
      region = "west_us_2"
    }

    database = {
      region = "east_asia"
    }

    monitoring = {
      region = "east_asia"
    }

    jenkins = {
      region = "korea_central"
    }

    additional-depedencies = {
      region = "korea_central"
    }
  }
}



# VM


variable "username" {
  default = "azureuser"
}

variable "vm_size" {
  default = "Standard_B2als_v2"
}



# SSH


variable "ssh_public_key_path" {
  default = "~/.ssh/id_ed25519.pub"
}


# STORAGE


variable "storage_account_type" {
  default = "Standard_LRS"
}

variable "data_disk_size_gb" {
  default = 10
}

variable "data_disk_caching" {
  default = "ReadWrite"
}