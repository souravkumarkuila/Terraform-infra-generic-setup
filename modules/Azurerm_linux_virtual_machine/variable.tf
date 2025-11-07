# Virtual Machine (Linux)
variable "vms" {
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
    # network_interface_ids           = list(string)  # if we using data block for this then not required here
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
