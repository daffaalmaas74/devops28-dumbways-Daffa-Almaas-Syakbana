# RESOURCE GROUP - AUSTRALIA EAST

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}


# VNET - AUSTRALIA EAST

resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "main" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.subnet_address_prefixes
}



# NSG - AUSTRALIA EAST

resource "azurerm_network_security_group" "main" {
  name                = var.nsg_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "allow-22"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                  = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-80"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                  = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-443"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                  = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-3333"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                  = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3333"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}


# PUBLIC IP - MASTER

resource "azurerm_public_ip" "master" {
  name                = "pip-master"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}



# PUBLIC IP - WORKER-1

resource "azurerm_public_ip" "worker_1" {
  name                = "pip-worker-1"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}



# NIC - MASTER

resource "azurerm_network_interface" "master" {
  name                = "nic-master"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.master.id
  }
}



# NIC - WORKER-1

resource "azurerm_network_interface" "worker_1" {
  name                = "nic-worker-1"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.worker_1.id
  }
}



# NSG ASSOCIATION - MASTER

resource "azurerm_network_interface_security_group_association" "master" {
  network_interface_id      = azurerm_network_interface.master.id
  network_security_group_id = azurerm_network_security_group.main.id
}



# NSG ASSOCIATION - WORKER-1

resource "azurerm_network_interface_security_group_association" "worker_1" {
  network_interface_id      = azurerm_network_interface.worker_1.id
  network_security_group_id = azurerm_network_security_group.main.id
}



# MASTER - UBUNTU

resource "azurerm_linux_virtual_machine" "master" {
  name                = "master"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = var.vm_size
  admin_username      = var.username

  network_interface_ids = [
    azurerm_network_interface.master.id
  ]

  admin_ssh_key {
    username   = var.username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = var.data_disk_caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}



# WORKER-1 - UBUNTU

resource "azurerm_linux_virtual_machine" "worker_1" {
  name                = "worker-1"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = var.vm_size
  admin_username      = var.username

  network_interface_ids = [
    azurerm_network_interface.worker_1.id
  ]

  admin_ssh_key {
    username   = var.username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = var.data_disk_caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}



# DATA DISK - MASTER

resource "azurerm_managed_disk" "master_data" {
  name                 = "disk-master"
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  storage_account_type = var.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.data_disk_size_gb
}



# DATA DISK - WORKER-1

resource "azurerm_managed_disk" "worker_1_data" {
  name                 = "disk-worker-1"
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  storage_account_type = var.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.data_disk_size_gb
}


# DATA DISK ATTACHMENT - MASTER

resource "azurerm_virtual_machine_data_disk_attachment" "master" {
  managed_disk_id    = azurerm_managed_disk.master_data.id
  virtual_machine_id = azurerm_linux_virtual_machine.master.id
  lun                = 0
  caching            = var.data_disk_caching
}



# DATA DISK ATTACHMENT - WORKER-1

resource "azurerm_virtual_machine_data_disk_attachment" "worker_1" {
  managed_disk_id    = azurerm_managed_disk.worker_1_data.id
  virtual_machine_id = azurerm_linux_virtual_machine.worker_1.id
  lun                = 0
  caching            = var.data_disk_caching
}


# WORKER-2 - JAPAN EAST

# RESOURCE GROUP - JAPAN EAST

resource "azurerm_resource_group" "worker_2" {
  name     = "rg-worker-2"
  location = "Japan East"
}


# VNET - JAPAN EAST

resource "azurerm_virtual_network" "worker_2" {
  name                = "vnet-worker-2"
  location            = azurerm_resource_group.worker_2.location
  resource_group_name = azurerm_resource_group.worker_2.name
  address_space       = ["10.1.0.0/16"]
}


# SUBNET - JAPAN EAST

resource "azurerm_subnet" "worker_2" {
  name                 = "subnet-worker-2"
  resource_group_name  = azurerm_resource_group.worker_2.name
  virtual_network_name = azurerm_virtual_network.worker_2.name
  address_prefixes     = ["10.1.1.0/24"]
}



# NSG - JAPAN EAST

resource "azurerm_network_security_group" "worker_2" {
  name                = "nsg-worker-2"
  location            = azurerm_resource_group.worker_2.location
  resource_group_name = azurerm_resource_group.worker_2.name

  security_rule {
    name                       = "allow-22"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                  = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-80"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                  = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-443"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                  = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-3333"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                  = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3333"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}



# PUBLIC IP - WORKER-2

resource "azurerm_public_ip" "worker_2" {
  name                = "pip-worker-2"
  location            = azurerm_resource_group.worker_2.location
  resource_group_name = azurerm_resource_group.worker_2.name
  allocation_method   = "Static"
  sku                 = "Standard"
}



# NIC - WORKER-2

resource "azurerm_network_interface" "worker_2" {
  name                = "nic-worker-2"
  location            = azurerm_resource_group.worker_2.location
  resource_group_name = azurerm_resource_group.worker_2.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.worker_2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.worker_2.id
  }
}



# NSG ASSOCIATION - WORKER-2

resource "azurerm_network_interface_security_group_association" "worker_2" {
  network_interface_id      = azurerm_network_interface.worker_2.id
  network_security_group_id = azurerm_network_security_group.worker_2.id
}



# WORKER-2 - UBUNTU

resource "azurerm_linux_virtual_machine" "worker_2" {
  name                = "worker-2"
  resource_group_name = azurerm_resource_group.worker_2.name
  location            = azurerm_resource_group.worker_2.location
  size                = var.vm_size
  admin_username      = var.username

  network_interface_ids = [
    azurerm_network_interface.worker_2.id
  ]

  admin_ssh_key {
    username   = var.username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = var.data_disk_caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}


# DATA DISK - WORKER-2

resource "azurerm_managed_disk" "worker_2_data" {
  name                 = "disk-worker-2"
  location             = azurerm_resource_group.worker_2.location
  resource_group_name  = azurerm_resource_group.worker_2.name
  storage_account_type = var.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.data_disk_size_gb
}



# DATA DISK ATTACHMENT - WORKER-2

resource "azurerm_virtual_machine_data_disk_attachment" "worker_2" {
  managed_disk_id    = azurerm_managed_disk.worker_2_data.id
  virtual_machine_id = azurerm_linux_virtual_machine.worker_2.id
  lun                = 0
  caching            = var.data_disk_caching
}



# VNET PEERING - AUSTRALIA EAST TO JAPAN EAST

resource "azurerm_virtual_network_peering" "australia_to_japan" {
  name                      = "peer-australia-to-japan"
  resource_group_name       = azurerm_resource_group.main.name
  virtual_network_name      = azurerm_virtual_network.main.name
  remote_virtual_network_id = azurerm_virtual_network.worker_2.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}



# VNET PEERING - JAPAN EAST TO AUSTRALIA EAST

resource "azurerm_virtual_network_peering" "japan_to_australia" {
  name                      = "peer-japan-to-australia"
  resource_group_name       = azurerm_resource_group.worker_2.name
  virtual_network_name      = azurerm_virtual_network.worker_2.name
  remote_virtual_network_id = azurerm_virtual_network.main.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}