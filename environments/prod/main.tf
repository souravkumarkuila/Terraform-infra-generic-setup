module "rg-prod" {
  source = "../../modules/Azurerm_resource_group"

  rgs = var.rg_main
}

module "vnet-prod" {
  source = "../../modules/Azurerm_virtual_network"

  vnets      = var.vnet_main
  depends_on = [module.rg-prod]
}

module "subnet-prod" {
  source = "../../modules/azurerm_subnet"

  subnets    = var.subnet-main
  depends_on = [module.vnet-prod]
}


