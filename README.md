🌐 Azure Infrastructure Deployment Using Terraform (Generic & Modular)

This repository provides a fully modular, reusable, and scalable Terraform setup for deploying complete Azure infrastructure.
You can provision Resource Groups, VNets, Subnets, NSGs, NICs, Public IPs, Storage Accounts, Key Vaults, Secrets, and Virtual Machines — all dynamically using maps and environment-specific .tfvars.

🚀 Features

✅ Modular Design — each Azure resource has its own Terraform module
✅ Dynamic for_each Mapping — create multiple resources from a single .tfvars
✅ Data Sources — auto-fetch Subnet, NIC, NSG, and Key Vault IDs
✅ Dynamic & Optional Blocks — using dynamic + try() for flexible configs
✅ Environment-Based Structure — supports dev, qa, prod
✅ Dependency Safe — automatic ordering using lookups & depends_on
✅ Secure Secrets Management — via Azure Key Vault modules
✅ VM Deployment — Linux VMs with NIC, diagnostics, and image inputs

🏗️ Project Structure
📦 Azure_Resource_code_For_each_Tfvars/
│
├── modules/
│   ├── azurerm_resource_group/
│   ├── azurerm_virtual_network/
│   ├── azurerm_subnet/
│   ├── azurerm_network_security_group/
│   ├── azurerm_public_ip/
│   ├── azurerm_network_interface/
│   ├── azurerm_nic_nsg_association/
│   ├── azurerm_storage_account/
│   ├── azurerm_key_vault/
│   ├── azurerm_key_vault_secret/
│   └── azurerm_linux_virtual_machine/
│
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── providers.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars
│   │   └── outputs.tf
│   └── prod/
│       └── ...
│
└── README.md

⚙️ Prerequisites

Before running this project, ensure you have:

✅ Terraform

Version 1.6+

✅ Azure CLI Installed & Logged In
az login
az account set --subscription "<your-subscription-id>"

✅ Permissions

Contributor / Owner access to create Azure resources

🧩 Modules Overview
Module	Description
azurerm_resource_group	Creates Resource Groups
azurerm_virtual_network	Creates Virtual Networks
azurerm_subnet	Creates Subnets
azurerm_network_security_group	Creates NSGs
azurerm_public_ip	Creates Public IP addresses
azurerm_network_interface	Creates NICs with Subnet & PIP assignment
azurerm_nic_nsg_association	Associates NICs with NSGs
azurerm_storage_account	Storage Accounts for logs/data
azurerm_key_vault	Creates Key Vaults
azurerm_key_vault_secret	Stores secrets securely
azurerm_linux_virtual_machine	Creates Linux VMs
🔑 Key Vault Module Example
keyvault-main = {
  kv1 = {
    name                        = "kv-dev"
    location                    = "East US"
    resource_group_name         = "rg-dev"
    sku_name                    = "standard"
    tenant_id                   = "your-tenant-id"
    soft_delete_enabled         = true
    purge_protection_enabled    = false
    tags = { environment = "dev" }
  }
}

🔐 Key Vault Secret Module Example
keyvaultsecret-main = {
  secret1 = {
    name         = "adminPassword"
    value        = "P@ssword123!"
    key_vault_id = "/subscriptions/<sub_id>/resourceGroups/rg-dev/providers/Microsoft.KeyVault/vaults/kv-dev"
    tags         = { environment = "dev" }
  }
}

🌍 Public IP Module Example
pip-main = {
  pip1 = {
    name                = "pip-dev"
    location            = "East US"
    resource_group_name = "rg-dev"
    allocation_method   = "Dynamic"
    sku                 = "Basic"
    tags                = { environment = "dev" }
  }
}

📄 Example terraform.tfvars (Dev)

✅ VNet

vnet-main = {
  vnet1 = {
    name                = "vnet-dev"
    location            = "East US"
    resource_group_name = "rg-dev"
    address_space       = ["10.0.0.0/16"]
    tags = { environment = "dev", project = "project-x" }
  }
}


✅ Subnet

subnet-main = {
  subnet1 = {
    name                = "subnet-dev1"
    resource_group_name = "rg-dev"
    vnet_name           = "vnet-dev"
    address_prefixes    = ["10.0.0.0/24"]
  }
}


✅ NSG

nsg-main = {
  nsg1 = {
    name                = "nsg-dev"
    location            = "East US"
    resource_group_name = "rg-dev"
  }
}


✅ Public IP

pip-main = {
  pip1 = {
    name                = "pip-dev"
    location            = "East US"
    resource_group_name = "rg-dev"
    allocation_method   = "Dynamic"
    sku                 = "Basic"
    tags                = { environment = "dev" }
  }
}


✅ Key Vault

keyvault-main = {
  kv1 = {
    name                        = "kv-dev"
    location                    = "East US"
    resource_group_name         = "rg-dev"
    sku_name                    = "standard"
    tenant_id                   = "xxxx-xxxx-xxxx"
    soft_delete_enabled         = true
    purge_protection_enabled    = false
    tags = { environment = "dev" }
  }
}


✅ Key Vault Secret

keyvaultsecret-main = {
  secret1 = {
    name         = "adminPassword"
    value        = "P@ssword123!"
    key_vault_id = "/subscriptions/<sub_id>/resourceGroups/rg-dev/providers/Microsoft.KeyVault/vaults/kv-dev"
    tags         = { environment = "dev" }
  }
}


✅ NIC

nic-main = {
  nic1 = {
    name                = "nic-dev"
    location            = "East US"
    resource_group_name = "rg-dev"
    vnet_name           = "vnet-dev"
    subnet_name         = "subnet-dev1"
    pip_name            = "pip-dev"
    enable_ip_forwarding          = false
    enable_accelerated_networking = false
    tags = { environment = "dev" }

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


✅ VM

vms-main = {
  vm1 = {
    name                            = "vm-dev"
    location                        = "East US"
    resource_group_name             = "rg-dev"
    size                            = "Standard_B2s"
    admin_username                  = "azureuser"
    admin_password                  = "P@ssword123!"
    disable_password_authentication = false
    nic_name                        = "nic-dev"

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
    tags             = { environment = "dev" }
  }
}

🚀 Deployment Steps
✅ 1. Initialize
terraform init

✅ 2. Validate
terraform validate

✅ 3. Plan
terraform plan

✅ 4. Apply
terraform apply -auto-approve

✅ 5. Destroy (Optional)
terraform destroy -auto-approve

🧠 Highlights

Fully modular & reusable

Dynamic for_each for scalable creation

Automatically retrieves resource IDs

Secure secrets via Key Vault

Clear separation: dev / qa / prod

Complete resource dependency chaining

🧾 Outputs

Common outputs include:

✅ Resource Group Names
✅ VNet & Subnet IDs
✅ Public IPs & NIC IDs
✅ Key Vault URIs
✅ VM Private/Public IPs

Check outputs:

terraform output

🧰 Troubleshooting
Issue	Cause	Resolution
subnet_id is required	Subnet not found	Check VNet & Subnet names
network_interface_ids is required	NIC missing	Ensure NIC module & dependencies
ResourceNotFound (404)	Region mismatch	Match all resource locations
Provider produced inconsistent result	Azure API delays	Re-run apply/refresh
The specified resource does not exist	Wrong Key Vault / Storage settings	Match resource group & region
