terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.43.0"
    }
  }

  backend "azurerm" {
    resource_group_name   = "souravtodogenrg"
    storage_account_name  = "souravtodogenstore"
    container_name        = "souravtodogencont"
    key                   = "dev.terraform.tfstate"
    
  }
}

provider "azurerm" {
    features {}
}