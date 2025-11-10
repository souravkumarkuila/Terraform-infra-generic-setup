rg-main = {
  rg1 = {
    name       = "rg-dev-souravkuila"
    location   = "Central US"
    managed_by = " managed by dev team"
    tags = {
      environment  = "dev"
      project      = "project-x"
      owner        = "dev-team"
      project_cost = "$10"


    }
  }
  rg2 = {
    name       = "rg-prod"
    location   = "central us"
    managed_by = " managed by prod team"
    tags = {
      environment  = "prod"
      project      = "project-y"
      owner        = "prod-team"
      project_cost = "$10"
    }

  }
}

stg-main = {
  stg1 = {
    name                     = "stgdevaccount37"
    resource_group_name      = "rg-dev-souravkuila"
    location                 = "Central US"
    account_tier             = "Standard"
    account_replication_type = "LRS"

    # Optional parameters
    account_kind               = "StorageV2"
    access_tier                = "Hot"
    https_traffic_only_enabled = true
    min_tls_version            = "TLS1_2"
    tags = {
      environment  = "dev"
      project      = "project-x"
      owner        = "dev-team"
      project_cost = "$10"
    }
    network_rules = [
      {
        default_action = "Deny"
        bypass         = ["AzureServices"]
        ip_rules       = ["152.58.134.176"]
      }
    ]
  }
  stg2 = {
    name                     = "storeprodskg"
    resource_group_name      = "rg-prod"
    location                 = "Central US"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cold"

    # Optional parameters
    tags = {
      environment  = "prod"
      project      = "project-y"
      owner        = "prod-team"
      project_cost = "$10"
    }
    network_rules = []

  }
}

vnet-main = {
  vnet1 = {
    name                = "vnet-dev"
    location            = "Central US"
    resource_group_name = "rg-dev-souravkuila"
    address_space       = ["10.0.0.0/16"]
    tags = {
      environment  = "dev"
      project      = "project-x"
      owner        = "dev-team"
      project_cost = "$10"
    }
    subnets = [
      {
        name           = "subnet-dev1"
        address_prefix = ["10.0.1.0/24"]
      }
      ,
      {
        name           = "subnet-dev2"
        address_prefix = ["10.0.2.0/24"]
      }
    ]
  }
}

pip-main = {
  pip1 = {
    name                = "pip-dev"
    location            = "Central US"
    resource_group_name = "rg-dev-souravkuila"
    allocation_method   = "Static"
    tags = {
      environment  = "dev"
      project      = "project-x"
      owner        = "dev-team"
      project_cost = "$10"
    }
  }

  pip2 = {
    name                    = "pip-prod"
    location                = "Central US"
    resource_group_name     = "rg-prod"
    allocation_method       = "Static"
    sku                     = "Standard"
    idle_timeout_in_minutes = 15
    tags = {
      environment  = "prod"
      project      = "project-y"
      owner        = "prod-team"
      project_cost = "$10"
    }
  }
}

nsg-main = {
  nsg1 = {
    name                = "nsg-dev"
    location            = "Central US"
    resource_group_name = "rg-dev-souravkuila"
    tags = {
      environment = "dev"
    }

    security_rules = [
      {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

nic-main = {
  nic1 = {
    vnet_name                     = "vnet-dev"
    subnet_name                   = "subnet-dev1"
    pip_name                      = "pip-dev"
    name                          = "nic-dev"
    location                      = "Central US"
    resource_group_name           = "rg-dev-souravkuila"
    enable_ip_forwarding          = false
    enable_accelerated_networking = false
    tags                          = { environment = "dev" }

    ip_configurations = [
      {
        name                          = "ipconfig1"
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
        primary                       = true
      }
    ]
  }
}

nic_nsg_association-main = {
  assoc1 = {
    nic_name            = "nic-dev"
    nsg_name            = "nsg-dev"
    resource_group_name = "rg-dev-souravkuila"
  }
}

vms-main = {
  vm1 = {
    name                            = "vm-dev"
    location                        = "Central US"
    resource_group_name             = "rg-dev-souravkuila"
    size                            = "Standard_B1s"
    admin_username                  = "azureuser"
    admin_password                  = "P@ssword123!"
    disable_password_authentication = false
    nic_name                        = "nic-dev"
    provision_vm_agent              = true

    source_image_reference = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }

    os_disk = [{
      name                 = "vm-dev-osdisk"
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 30
    }]

    admin_ssh_key    = []
    boot_diagnostics = []
    tags = {
      environment = "dev"
    }
  }
}

key_vaults = {
  kv-dev = {
    name                            = "kv-todoappsouravkuila"
    resource_group_name             = "rg-dev-souravkuila"
    location                        = "Central US"
    sku_name                        = "standard"
    enabled_for_deployment          = true
    enabled_for_disk_encryption     = true
    enabled_for_template_deployment = false
    purge_protection_enabled        = false
    soft_delete_retention_days      = 7

    access_policies = [
      {

        key_permissions         = ["Get", "List", "Create", "Delete"]
        secret_permissions      = ["Get", "List", "Set", "Delete", "Recover"]
        certificate_permissions = ["Get", "List", "Create"]
        storage_permissions     = ["Get", "List"]
      }
    ]

    tags = {
      environment = "dev"
      owner       = "sourav"
      project     = "terraform-modular-demo"
      costcenter  = "cc001"
    }
  }
}

kv_secrets = {
  secret1 = {
    kv_name      = "kv-todoappsouravkuila"
    rg_name      = "rg-dev-souravkuila"
    secret_name  = "vm-adminusername"
    secret_value = "azureuser"

  },
  secret2 = {
    kv_name      = "kv-todoappsouravkuila"
    rg_name      = "rg-dev-souravkuila"
    secret_name  = "vm-adminpassword"
    secret_value = "P@ssword123!"
  },
  secret3 = {
    kv_name      = "kv-todoappsouravkuila"
    rg_name      = "rg-dev-souravkuila"
    secret_name  = "sql-adminusername"
    secret_value = "sqladmintodo"
  },
  secret4 = {
    kv_name      = "kv-todoappsouravkuila"
    rg_name      = "rg-dev-souravkuila"
    secret_name  = "sql-adminpassword"
    secret_value = "P@ssword123!"
  }
}
