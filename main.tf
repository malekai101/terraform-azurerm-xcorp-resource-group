//To be removed after testing
/*
provider "azurerm" {
  features {}
}
*/

locals {
  project_string = "${replace(var.project_name, " ", "_")}_${var.project_environment}"
}

resource "azurerm_resource_group" "dev_rg" {
  name     = "${local.project_string}-resources"
  location = var.location
  tags = {
    "Project" = var.project_name
    "Scope"   = var.project_environment
  }
}

resource "azurerm_virtual_network" "dev_network" {
  name                = "${local.project_string}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.dev_rg.location
  resource_group_name = azurerm_resource_group.dev_rg.name

  tags = {
    "Project" = var.project_name
    "Scope"   = var.project_environment
  }
}

resource "azurerm_subnet" "web_subnet" {
  name                 = "${local.project_string}-web-subnet"
  resource_group_name  = azurerm_resource_group.dev_rg.name
  virtual_network_name = azurerm_virtual_network.dev_network.name
  address_prefixes     = ["10.0.2.0/24"]


}

resource "azurerm_network_security_group" "ssh_rule" {
  name                = "${local.project_string}-security-ssh"
  location            = azurerm_resource_group.dev_rg.location
  resource_group_name = azurerm_resource_group.dev_rg.name

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.admin_network
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "web_rule" {
  name                = "${local.project_string}-security-web"
  location            = azurerm_resource_group.dev_rg.location
  resource_group_name = azurerm_resource_group.dev_rg.name

  security_rule {
    name                         = "http"
    priority                     = 101
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_range       = "80"
    source_address_prefix        = "*"
    destination_address_prefixes = azurerm_subnet.web_subnet.address_prefixes
  }
  security_rule {
    name                         = "https"
    priority                     = 102
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_range       = "443"
    source_address_prefix        = "*"
    destination_address_prefixes = azurerm_subnet.web_subnet.address_prefixes
  }
}