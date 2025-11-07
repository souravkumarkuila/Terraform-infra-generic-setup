terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.43.0"
    }
  }

#   backend "azurerm" {
#     resource_group_name   = "Souravgenerg"
#     storage_account_name  = "kuilastorage"
#     container_name        = "prodkuila"
#     key                   = "production.terraform.tfstate"
    
#   }
}

provider "azurerm" {
  features {}
}
