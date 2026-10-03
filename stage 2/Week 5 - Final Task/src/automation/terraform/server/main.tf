# RESOURCE GROUPS

resource "azurerm_resource_group" "region" {
  for_each = var.regions

  name     = each.value.resource_group_name
  location = each.value.location
}


# VNET

resource "azurerm_virtual_network" "region" {
  for_each = var.regions

  name                = each.value.vnet_name
  location            = azurerm_resource_group.region[each.key].location
  resource_group_name = azurerm_resource_group.region[each.key].name
  address_space       = [each.value.vnet_address_space]
}



# SUBNET

resource "azurerm_subnet" "region" {
  for_each = var.regions

  name                 = each.value.subnet_name
  resource_group_name  = azurerm_resource_group.region[each.key].name
  virtual_network_name = azurerm_virtual_network.region[each.key].name
  address_prefixes     = [each.value.subnet_address_prefix]
}



# NSG

resource "azurerm_network_security_group" "region" {
  for_each = var.regions

  name                = each.value.nsg_name
  location            = azurerm_resource_group.region[each.key].location
  resource_group_name = azurerm_resource_group.region[each.key].name

  security_rule {
    name                       = "allow-22"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
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
    protocol                   = "Tcp"
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
    protocol                   = "Tcp"
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



# PUBLIC IP

resource "azurerm_public_ip" "server" {
  for_each = var.servers

  name                = "pip-${each.key}"
  location            = azurerm_resource_group.region[each.value.region].location
  resource_group_name = azurerm_resource_group.region[each.value.region].name
  allocation_method   = "Static"
  sku                 = "Standard"
}



# NETWORK INTERFACE

resource "azurerm_network_interface" "server" {
  for_each = var.servers

  name                = "nic-${each.key}"
  location            = azurerm_resource_group.region[each.value.region].location
  resource_group_name = azurerm_resource_group.region[each.value.region].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.region[each.value.region].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.server[each.key].id
  }
}



# NSG ASSOCIATION

resource "azurerm_network_interface_security_group_association" "server" {
  for_each = var.servers

  network_interface_id      = azurerm_network_interface.server[each.key].id
  network_security_group_id = azurerm_network_security_group.region[each.value.region].id
}



# VIRTUAL MACHINE

resource "azurerm_linux_virtual_machine" "server" {
  for_each = var.servers

  name                = each.key
  resource_group_name = azurerm_resource_group.region[each.value.region].name
  location            = azurerm_resource_group.region[each.value.region].location
  size                = var.vm_size
  admin_username      = var.username

  network_interface_ids = [
    azurerm_network_interface.server[each.key].id
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



# DATA DISK

resource "azurerm_managed_disk" "server_data" {
  for_each = var.servers

  name                 = "disk-${each.key}"
  location             = azurerm_resource_group.region[each.value.region].location
  resource_group_name  = azurerm_resource_group.region[each.value.region].name
  storage_account_type = var.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.data_disk_size_gb
}



# DATA DISK ATTACHMENT

resource "azurerm_virtual_machine_data_disk_attachment" "server" {
  for_each = var.servers

  managed_disk_id    = azurerm_managed_disk.server_data[each.key].id
  virtual_machine_id = azurerm_linux_virtual_machine.server[each.key].id
  lun                = 0
  caching            = var.data_disk_caching
}