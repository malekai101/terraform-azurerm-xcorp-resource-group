# xcorp-resource-group
A Terraform module for an AzureRM resource group and basic network

## Overview
This module creates an Azure resource group with networks, subnets, and security rules mandated by EA and SSO.

## Requirements
The `azurerm` ressource must be used in the project.  The account used must have rights to create the resources in the module.

## Usage

## Usage

```hcl
provider azurerm {
}

module "xcorp-resource-group" {
    source = "app.terraform.io/csmith/xcorp-resource-group/azure"

    admin_network       = "x.x.x.x/32"
    project_name        = "Demo Test"
    project_environment = "DEV"
    location            = "East US"
}
```
