rg-main = {
    rg1 = {
        name     = "rg-prod"
        location = "centralindia"
    }
    
}

vnet-main = {
    vnet1 = {
        name                = "vnet-prod"
        location            = "centralindia"
        resource_group_name = "rg-prod"
        address_space       = ["10.0.0.0/16"]
    }
}

subnet-main = {
    subnet1 = {
        name                 = "subnet-prod"
        resource_group_name  = "rg-prod"
        virtual_network_name = "vnet-prod"
        address_prefixes     = ["10.0.1.0/24"]
    }
}