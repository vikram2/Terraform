terraform {
  required_version = ">1.0.9"
    required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.65.0"
    }
  }
}

provider "azurerm" {
  subscription_id = ""
  tenant_id = ""
  client_id = ""
  client_secret = ""
  features {}
}

resource "azurerm_resource_group" "appgrp" {
  name     = "appgrp"
  location = "Central US"
}

resource "azurerm_app_service_plan" "vikplan" {
  name                = "vikplan"
  location            = "Central US"
  resource_group_name = "appgrp"
  kind                = "Linux"
  reserved            = true
  depends_on = [
    azurerm_resource_group.appgrp
  ]

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "pariservice" {
  name                = "pari-app-service"
  location            = "Central US"
  resource_group_name = "appgrp"
  app_service_plan_id = azurerm_app_service_plan.vikplan.id
  depends_on = [
    azurerm_resource_group.appgrp,
  ]
}
