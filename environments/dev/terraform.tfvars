rgs = {
  rg1 = {
    name       = "rg-todoappprojects"
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

stgs = {
  stg1 = {
    name                     = "stgdevaccount129"
    resource_group_name      = "rg-todoappprojects"
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
    name                     = "stgprodaccount124"
    resource_group_name      = "rg-prod"
    location                 = "East US"
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

vnets = {
  vnet1 = {
    name                = "vnet-todo"
    location            = "Central US"
    resource_group_name = "rg-todoappprojects"
    address_space       = ["10.0.0.0/16"]
    tags = {
      environment  = "dev"
      project      = "project-x"
      owner        = "dev-team"
      project_cost = "$10"
    }
    subnets = [
      {
        name           = "frontend-subnet"
        address_prefix = ["10.0.1.0/24"]
      }
      ,
      {
        name           = "backend-subnet"
        address_prefix = ["10.0.2.0/24"]
      }
    ]
  }
}

pips = {
  pip1 = {
    name                = "pip-frontend"
    location            = "Central US"
    resource_group_name = "rg-todoappprojects"
    allocation_method   = "Static"
    tags = {
      environment  = "dev"
      project      = "project-x"
      owner        = "dev-team"
      project_cost = "$10"
    }
  }

  pip2 = {
    name                    = "pip-backend"
    location                = "Central US"
    resource_group_name     = "rg-todoappprojects"
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

nsgs = {
  nsg1 = {
    name                = "nsg-frontend"
    location            = "Central US"
    resource_group_name = "rg-todoappprojects"
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
      },
      {
        name                       = "HTTP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]

  }

  nsg2 = {
    name                = "nsg-backend"
    location            = "Central US"
    resource_group_name = "rg-todoappprojects"
    tags = {
      environment = "dev"
    }

    security_rules = [
      {
        name                       = "HTTP"
        priority                   = 1003
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

nics = {
  nic1 = {
    vnet_name                     = "vnet-todo"
    subnet_name                   = "frontend-subnet"
    pip_name                      = "pip-frontend"
    name                          = "nic-frontend"
    location                      = "Central US"
    resource_group_name           = "rg-todoappprojects"
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
  nic2 = {
    vnet_name                     = "vnet-todo"
    subnet_name                   = "backend-subnet"
    pip_name                      = "pip-backend"
    name                          = "nic-backend"
    location                      = "Central US"
    resource_group_name           = "rg-todoappprojects"
    enable_ip_forwarding          = false
    enable_accelerated_networking = false
    tags                          = { environment = "dev" }

    ip_configurations = [
      {
        name                          = "ipconfig2"
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
        primary                       = true
      }
    ]
  }
}

nic_nsg_association = {
  assoc1 = {
    nic_name            = "nic-frontend"
    nsg_name            = "nsg-frontend"
    resource_group_name = "rg-todoappprojects"
  }
  assoc2 = {
    nic_name            = "nic-backend"
    nsg_name            = "nsg-backend"
    resource_group_name = "rg-todoappprojects"
  }
}

vms = {
  vm1 = {
    name                            = "vm-todo-frontend"
    location                        = "Central US"
    resource_group_name             = "rg-todoappprojects"
    size                            = "Standard_B1s"
    disable_password_authentication = false
    nic_name                        = "nic-frontend"
    kv_name                         = "kv-todo-souravlockes"
    vm_username_secret_name         = "vm-adminusername"
    vm_password_secret_name         = "vm-adminpassword"
    provision_vm_agent              = true
    script_name                     = "middleware_nginx.sh"
    source_image_reference = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }

    os_disk = [
      {
        name                 = "vm-todo-frontend-osdisk"
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
        disk_size_gb         = 30
      }
    ]

    admin_ssh_key    = []
    boot_diagnostics = []
    tags = {
      environment = "dev"
    }
  }
  vm2 = {
    name                            = "vm-todo-backend"
    location                        = "Central US"
    resource_group_name             = "rg-todoappprojects"
    size                            = "Standard_B1s"
    disable_password_authentication = false
    nic_name                        = "nic-backend"
    kv_name                         = "kv-todo-souravlockes"
    vm_username_secret_name         = "vm-adminusername"
    vm_password_secret_name         = "vm-adminpassword"
    provision_vm_agent              = true
    script_name                     = "middleware_nginx.sh"

    source_image_reference = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }

    os_disk = [{
      name                 = "vm-todo-backend-osdisk"
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
    name                            = "kv-todo-souravlockes"
    resource_group_name             = "rg-todoappprojects"
    location                        = "eastus"
    sku_name                        = "standard"
    enabled_for_deployment          = true
    enabled_for_disk_encryption     = true
    enabled_for_template_deployment = false
    purge_protection_enabled        = true
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
      owner       = "ershad"
      project     = "terraform-modular-demo"
      costcenter  = "cc001"
    }
  }
}

kv_secrets = {
  secret1 = {
    kv_name      = "kv-todo-souravlockes"
    rg_name      = "rg-todoappprojects"
    secret_name  = "vm-adminusername"
    secret_value = "azureuser"

  },
  secret2 = {
    kv_name      = "kv-todo-souravlockes"
    rg_name      = "rg-todoappprojects"
    secret_name  = "vm-adminpassword"
    secret_value = "P@ssword123!"
  },
  secret3 = {
    kv_name      = "kv-todo-souravlockes"
    rg_name      = "rg-todoappprojects"
    secret_name  = "sql-adminusername"
    secret_value = "sqladmintodo"
  },
  secret4 = {
    kv_name      = "kv-todo-souravlockes"
    rg_name      = "rg-todoappprojects"
    secret_name  = "sql-adminpassword"
    secret_value = "P@ssword123!"
  }
}


sql_servers = {
  sql1 = {
    name                                     = "sourav-dev-eastus-sqlsrv"
    resource_group_name                      = "rg-todoappprojects"
    location                                 = "Central US"
    version                                  = "12.0"
    kv_name                                  = "kv-todo-souravlockes"
    sql_username_secret_name                 = "sql-adminusername"
    sql_password_secret_name                 = "sql-adminpassword"
    connection_policy                        = "Default"
    express_vulnerability_assessment_enabled = true
    minimum_tls_version                      = "1.2"
    public_network_access_enabled            = true
    outbound_network_restriction_enabled     = false

    identity = [
      {
        type         = "SystemAssigned"
        identity_ids = []
      }
    ]

    tags = {
      project     = "todo-app"
      environment = "dev"
      managed_by  = "terraform"
    }
  }
}

sql_databases = {
  sql_db1 = {
    name                = "todomciro-database"
    server_name         = "sourav-dev-eastus-sqlsrv"
    resource_group_name = "rg-todoappprojects"
    location            = "Central US"
    sku_name            = "S0"
    max_size_gb         = 10
    read_scale          = false
    zone_redundant      = false
    collation           = "SQL_Latin1_General_CP1_CI_AS"
    create_mode         = "Default"

    tags = {
      project     = "todo-app"
      environment = "dev"
      managed_by  = "terraform"

    }
  }
}


