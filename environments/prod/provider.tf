terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.43.0"
    }
  }

 
  backend "azurerm" {
    # resource_group_name  = "rg-todoappproj"
    # storage_account_name = "sgtodoapppro"
    # container_name       = "conttodoapppro"
    # key                  = "prod.terraform.tfstate"

  }
}

provider "azurerm" {
  features {}
subscription_id = "b4461466-1e6b-4be2-bb70-1e96a72a41c8"


}
