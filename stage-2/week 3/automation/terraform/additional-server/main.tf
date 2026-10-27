resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

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

resource "azurerm_network_security_group" "main" {
  name                = var.nsg_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "allow-all-inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-all-outbound"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "0.0.0.0/0"
  }
}

resource "azurerm_public_ip" "ubuntu_2" {
  name                = "pip-ubuntu-server-2"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "ubuntu_3" {
  name                = "pip-ubuntu-server-3"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "ubuntu_2" {
  name                = "nic-ubuntu-server-2"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ubuntu_2.id
  }
}

resource "azurerm_network_interface" "ubuntu_3" {
  name                = "nic-ubuntu-server-3"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ubuntu_3.id
  }
}

resource "azurerm_network_interface_security_group_association" "ubuntu_2" {
  network_interface_id      = azurerm_network_interface.ubuntu_2.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_network_interface_security_group_association" "ubuntu_3" {
  network_interface_id      = azurerm_network_interface.ubuntu_3.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_linux_virtual_machine" "ubuntu_2" {
  name                = "ubuntu-server-2"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = var.vm_size
  admin_username      = var.username

  network_interface_ids = [
    azurerm_network_interface.ubuntu_2.id
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

resource "azurerm_linux_virtual_machine" "ubuntu_3" {
  name                = "ubuntu-server-3"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = var.vm_size
  admin_username      = var.username

  network_interface_ids = [
    azurerm_network_interface.ubuntu_3.id
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

resource "azurerm_managed_disk" "ubuntu_2_data" {
  name                 = "disk-ubuntu-server-2"
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  storage_account_type = var.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.data_disk_size_gb
}

resource "azurerm_managed_disk" "ubuntu_3_data" {
  name                 = "disk-ubuntu-server-3"
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  storage_account_type = var.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.data_disk_size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "ubuntu_2" {
  managed_disk_id    = azurerm_managed_disk.ubuntu_2_data.id
  virtual_machine_id = azurerm_linux_virtual_machine.ubuntu_2.id
  lun                = 0
  caching            = var.data_disk_caching
}

resource "azurerm_virtual_machine_data_disk_attachment" "ubuntu_3" {
  managed_disk_id    = azurerm_managed_disk.ubuntu_3_data.id
  virtual_machine_id = azurerm_linux_virtual_machine.ubuntu_3.id
  lun                = 0
  caching            = var.data_disk_caching
}
