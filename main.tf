provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-wus-first-func"
  location = var.location
  tags = {
    Division = var.Division
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_app_service_plan" "example" {
  name                = "asp-wus-first-func"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}


terraform {
  required_version = "= 0.15.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.53.0"
    }
    artifactory = {
      source  = "jfrog/artifactory"
      version = "2.2.7"
    }
  }
}
