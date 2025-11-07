rg-main = {
  rg1 = {
    name       = "rg-dev"
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
    resource_group_name      = "rg-dev"
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
    resource_group_name = "rg-dev"
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
    resource_group_name = "rg-dev"
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
    resource_group_name = "rg-dev"
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
    resource_group_name           = "rg-dev"
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
    resource_group_name = "rg-dev"
  }
}

vms-main = {
  vm1 = {
    name                            = "vm-dev"
    location                        = "Central US"
    resource_group_name             = "rg-dev"
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
