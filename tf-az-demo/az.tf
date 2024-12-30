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
