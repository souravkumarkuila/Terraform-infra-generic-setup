module "rg-dev-souravkuila" {
  source = "../../modules/Azurerm_resource_group"

  rgs = var.rg-main
}

module "stg-dev" {
  source = "../../modules/Azurerm_storage_account"

  stgs       = var.stg-main
  depends_on = [module.rg-dev-souravkuila]
}

module "vnet-dev" {
  source = "../../modules/Azurerm_virtual_network"

  vnets      = var.vnet-main
  depends_on = [module.rg-dev-souravkuila]
}

module "pip-dev" {
  source = "../../modules/Azurerm_public_ip"

  public_ips = var.pip-main
  depends_on = [module.rg-dev-souravkuila]
}

module "nsg-dev" {
  source = "../../modules/Azurerm_network_security_group"

  nsgs       = var.nsg-main
  depends_on = [module.rg-dev-souravkuila]
}

module "nic-dev" {
  source = "../../modules/Azurerm_network_interface"

  nics       = var.nic-main
  depends_on = [module.rg-dev-souravkuila, module.pip-dev, module.vnet-dev]
}

module "nic_nsg_association-dev" {
  source              = "../../modules/Azurerm_nic_nsg_association"
  nic_nsg_association = var.nic_nsg_association-main
  depends_on          = [module.nic-dev, module.nsg-dev]
}

module "vm-dev" {
  source = "../../modules/Azurerm_linux_virtual_machine"

  vms        = var.vms-main
  depends_on = [module.rg-dev-souravkuila, module.nic-dev]
}

module "key_vault" {
  source = "../../modules/azurerm_key_vault"

  key_vaults = var.key_vaults
  depends_on = [module.rg-dev-souravkuila]
}

module "key_vault_secret" {
  source = "../../modules/azurerm_key_vault_secret"
  kv_secrets = var.kv_secrets
  depends_on = [module.key_vault]
}