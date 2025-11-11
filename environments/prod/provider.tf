terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.43.0"
    }
  }

  backend "azurerm" {
    resource_group_name   = "rgdeletenahikarna"
    storage_account_name  = "storedeletenahikarna"
    container_name        = "contdeletenahikarna"
    key                   = "prod.terraform.tfstate"
    
  }
}

provider "azurerm" {
  features {}
subscription_id = "6e65d60a-bc12-4f70-8dcd-6cdb4da48e3e"

}
