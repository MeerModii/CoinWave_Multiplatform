terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "coinwave_rg" {
  name     = "coinwave_rg"
  location = "eastus2"
  tags = {
    environment = "dev"
  }
}
resource "azurerm_virtual_network" "coinwave_vn" {
  name                = "coinwave_vn"
  resource_group_name = azurerm_resource_group.coinwave_rg.name
  location            = azurerm_resource_group.coinwave_rg.location
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "dev"
  }
}

resource "azurerm_subnet" "coinwave_storage_subnet" {
  name                 = "coinwave_storage_subnet"
  resource_group_name  = azurerm_resource_group.coinwave_rg.name
  virtual_network_name = azurerm_virtual_network.coinwave_vn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "coinwave_api_subnet" {
  name                 = "coinwave_api_subnet"
  resource_group_name  = azurerm_resource_group.coinwave_rg.name
  virtual_network_name = azurerm_virtual_network.coinwave_vn.name
  address_prefixes     = ["10.0.3.0/24"]
}