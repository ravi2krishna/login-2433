# Create a resource group
resource "azurerm_resource_group" "lms-2433" {
  name     = "2433-rg"
  location = "East Us"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "lms" {
  name                = "lms-vnet"
  resource_group_name = azurerm_resource_group.lms-2433.name
  location            = azurerm_resource_group.lms-2433.location
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "dev"
  }
}

# Web Subnet
resource "azurerm_subnet" "lms-web-sn" {
  name                 = "lms-web-subnet"
  resource_group_name  = azurerm_resource_group.lms-2433.name
  virtual_network_name = azurerm_virtual_network.lms.name
  address_prefixes     = ["10.0.0.0/24"]
}

# API Subnet
resource "azurerm_subnet" "lms-api-sn" {
  name                 = "lms-api-subnet"
  resource_group_name  = azurerm_resource_group.lms-2433.name
  virtual_network_name = azurerm_virtual_network.lms.name
  address_prefixes     = ["10.0.1.0/24"]
}

# DB Subnet
resource "azurerm_subnet" "lms-db-sn" {
  name                 = "lms-db-subnet"
  resource_group_name  = azurerm_resource_group.lms-2433.name
  virtual_network_name = azurerm_virtual_network.lms.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Public IP
resource "azurerm_public_ip" "lms-pip" {
  name                = "lms-web-pip"
  resource_group_name = azurerm_resource_group.lms-2433.name
  location            = azurerm_resource_group.lms-2433.location
  allocation_method   = "Static"

  tags = {
    environment = "lms-web-pip"
  }
}

# NIC
resource "azurerm_network_interface" "lms-web-nic" {
  name                = "lms-web-nic"
  location            = azurerm_resource_group.lms-2433.location
  resource_group_name = azurerm_resource_group.lms-2433.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.lms-web-sn.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.lms-pip.id
  }
}