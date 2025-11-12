terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.43.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-todoappprojects"
    storage_account_name = "sgtodoappprojects"
    container_name       = "conttodoappprojects"
    key                  = "dev.terraform.tfstate"

  }
}

provider "azurerm" {
  features {}
  subscription_id = "6e65d60a-bc12-4f70-8dcd-6cdb4da48e3e"

}
