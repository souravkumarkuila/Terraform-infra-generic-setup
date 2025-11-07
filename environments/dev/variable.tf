variable "rg-main" {
  type = map(object({
    name       = string                #name of the resource group
    location   = string                #location of the resource group
    managed_by = optional(string)      #who is managing the resource group
    tags       = optional(map(string)) #tag for specifying the project,owner,cost etc
  }))
}

variable "stg-main" {
  description = "Map of storage accounts configuration"
  type = map(object({
    # ---------- Required ----------
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string

    # ---------- Optional ----------

    account_kind                      = optional(string)
    provisioned_billing_model_version = optional(string)
    cross_tenant_replication_enabled  = optional(bool)
    access_tier                       = optional(string)
    edge_zone                         = optional(string)
    https_traffic_only_enabled        = optional(bool)
    min_tls_version                   = optional(string)
    allow_nested_items_to_be_public   = optional(bool)
    shared_access_key_enabled         = optional(bool)
    public_network_access_enabled     = optional(bool)
    default_to_oauth_authentication   = optional(bool)
    is_hns_enabled                    = optional(bool)
    nfsv3_enabled                     = optional(bool)
    large_file_share_enabled          = optional(bool)
    local_user_enabled                = optional(bool)
    queue_encryption_key_type         = optional(string)
    table_encryption_key_type         = optional(string)
    infrastructure_encryption_enabled = optional(bool)
    sftp_enabled                      = optional(bool)
    dns_endpoint_type                 = optional(string)
    allowed_copy_scope                = optional(string)
    tags                              = optional(map(string))
    network_rules = optional(list(object({
      default_action = string
      bypass         = optional(list(string))
      ip_rules       = optional(list(string))
    })), [])
  }))
}

variable "vnet-main" {
  description = "Map of Virtual Network configurations"
  type = map(object({
    name                    = string
    resource_group_name     = string
    location                = string
    address_space           = list(string)
    dns_servers             = optional(list(string))
    bgp_community           = optional(string)
    edge_zone               = optional(string)
    flow_timeout_in_minutes = optional(number)
    tags                    = optional(map(string))

    ddos_protection_plan = optional(list(object({
      id     = string
      enable = bool
    })), [])

    subnets = optional(list(object({
      name                                          = string
      address_prefix                                = list(string)
      service_endpoints                             = optional(list(string))
      private_endpoint_network_policies             = optional(bool)
      private_link_service_network_policies_enabled = optional(bool)
      delegation = optional(list(object({
        name = string
        service_delegation = object({
          name    = string
          actions = list(string)
        })
      })), [])
    })), [])
  }))
}


variable "pip-main" {
  description = "Map of public IP configurations"
  type = map(object({
    name                    = string
    location                = string
    resource_group_name     = string
    allocation_method       = string
    zones                   = optional(list(string))
    sku                     = optional(string)
    idle_timeout_in_minutes = optional(number)
    ip_tags                 = optional(map(string))
    ddos_protection_mode    = optional(string)
    ddos_protection_plan_id = optional(string)
    reverse_fqdn            = optional(string)
    domain_name_label       = optional(string)
    public_ip_prefix_id     = optional(string)
    tags                    = optional(map(string))
  }))
}


# Network Security Group (NSG)
variable "nsg-main" {
  description = "Map of Network Security Group configurations"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    tags                = optional(map(string))

    security_rules = optional(list(object({
      name                         = string
      priority                     = number
      direction                    = string
      access                       = string
      protocol                     = string
      source_port_range            = optional(string)
      destination_port_range       = optional(string)
      source_address_prefix        = optional(string)
      destination_address_prefix   = optional(string)
      source_port_ranges           = optional(list(string))
      destination_port_ranges      = optional(list(string))
      source_address_prefixes      = optional(list(string))
      destination_address_prefixes = optional(list(string))
    })), [])
  }))
}

# Network Interface (NIC)
variable "nic-main" {
  description = "Map of Network Interface configurations"
  type = map(object({
    # data block variable
    vnet_name   = string
    subnet_name = string
    pip_name    = string
    # resource block variable
    name                          = string
    resource_group_name           = string
    location                      = string
    enable_ip_forwarding          = optional(bool)
    enable_accelerated_networking = optional(bool)
    tags                          = optional(map(string))

    ip_configurations = optional(list(object({
      name = string
      # subnet_id                     = string # if we using data block for this then not required here
      private_ip_address_allocation = string
      private_ip_address_version    = optional(string)
      public_ip_address_id          = optional(string)
      primary                       = optional(bool)
    })), [])
  }))
}

# NIC ↔ NSG Association
variable "nic_nsg_association-main" {
  description = "Map defining NIC and NSG association"
  type = map(object({
    # data block variable
    nic_name            = string
    nsg_name            = string
    resource_group_name = string
    # resource block variable  # if we using data block for this then not required here
    # network_interface_id      = string
    # network_security_group_id = string
  }))
}

# Virtual Machine (Linux)
variable "vms-main" {
  description = "Map of Linux Virtual Machine configurations"
  type = map(object({
    # data block variable
    nic_name = string
    # resource block variable
    name                = string
    resource_group_name = string
    location            = string
    size                = string
    admin_username      = string
    admin_password      = optional(string)
    # network_interface_ids           = list(string) # if we using data block for this then not required here
    disable_password_authentication = optional(bool)
    computer_name                   = optional(string)
    custom_data                     = optional(string)
    provision_vm_agent              = optional(bool)
    allow_extension_operations      = optional(bool)
    edge_zone                       = optional(string)
    encryption_at_host_enabled      = optional(bool)
    patch_mode                      = optional(string)
    reboot_setting                  = optional(string)
    secure_boot_enabled             = optional(bool)
    vtpm_enabled                    = optional(bool)
    tags                            = optional(map(string))
    zone                            = optional(string)

    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })

    os_disk = optional(list(object({
      name                 = string
      caching              = string
      storage_account_type = string
      disk_size_gb         = optional(number)
    })), [])

    admin_ssh_key = optional(list(object({
      username   = string
      public_key = string
    })), [])

    boot_diagnostics = optional(list(object({
      storage_account_uri = string
    })), [])
  }))
}


